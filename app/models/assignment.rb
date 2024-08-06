class Assignment < ApplicationRecord
  include AASM
  has_ancestry
  geocoded_by :address 
  after_validation :geocode, :if => :address_changed?
     
  default_scope { order('id DESC') }

  belongs_to :parent, :class_name => "Assignment", foreign_key: 'parent_id', :optional => true
  belongs_to :location, :optional => true
  belongs_to :contractor, :class_name => "Chatroom", :foreign_key => "contractor_id", optional: true
  belongs_to :work, :class_name => "Master", :foreign_key => "work_id"

  belongs_to :user
  belongs_to :worker_user, :class_name => "User", :foreign_key => "worker_user_id", optional: true
  belongs_to :incharge_user, :class_name => "User", :foreign_key => "incharge_user_id", optional: true
  belongs_to :worker_user, :class_name => "User", :foreign_key => "worker_user_id", optional: true
  belongs_to :inspector, :class_name => "User", :foreign_key => "inspector_id", optional: true
  belongs_to :witness, :class_name => "User", :foreign_key => "witness_id", optional: true

  has_many :photos, as: :photoable, dependent: :destroy  
  has_many :defects, dependent: :destroy  

  enum status: [:Open, :Closed]

  scope :project, ->{ where(work_id: 25) }

  scope :assigned, ->{ where(state: :assigned) }
  scope :working, ->{ where(state: :working) }
  scope :rejected, ->{ where(state: :rejected) }
  scope :acknowledged, ->{ where(state: :acknowledged) }
  scope :reviewed, -> { where('star > ? and start_datetime > ?', 0, Time.now.utc.prev_month.end_of_month) }

#  before_create :assign_person_in_charge 
#  before_create :assign_task  
  before_create :set_default_values
#  before_save :set_default_values
#  after_create_commit :create_notification #, if: :incharge_user_id_changed? 
#  before_create :update_location if :contractor_id.blank? 
  before_create :set_no 
  before_update :syn_dates, :if => :date_range_changed?
#  after_create_commit :generate_hash

  aasm do
    state :booked, initial: true
    state :ordered
    state :quoted
    state :assigned 
    state :cancelled
    state :acknowledged
    state :working 
    state :rejected
    state :finished
    state :completed

    event :assign do
      transitions from: [:booked, :quoted, :ordered], to: :assigned
    end

    event :quote do
      transitions from: [:booked, :ordered], to: :quoted
    end
 
    event :acknowledge do
      transitions from: [:ordered, :booked, :assigned, :rejected], to: :acknowledged 
    end

    event :start do
      transitions from: [:assigned, :acknowledged, :rejected], to: :working  
    end

    event :finish do
      transitions from: [:acknowledged, :working], to: :finished   
    end

    event :accept do
      transitions from: [:booked, :finished], to: :acknowledged  
    end

    event :reject do
      transitions from: [:finished], to: :acknowledged    
    end

    event :complete do
      transitions from: [:working, :acknowledged, :booked, :finished], to: :completed    
    end

    event :cancel do
      transitions from: [:booked, :assigned, :working], to: :cancelled 
    end
  end

  def display_name
    "(#{no}) #{name}"
  end
  
  def to_label
    "(#{no}) #{name}"
  end

  def job
      " #{work.display_name}"
  end

  def job_short
      " #{work.code}"
  end

#def self.import(file)
#  spreadsheet = open_spreadsheet(file)
#  header = spreadsheet.row(1)
#  (2..spreadsheet.last_row).each do |i|
#    row = Hash[[header, spreadsheet.row(i)].transpose]
#    assignment = find_by_id(row["id"]) || new
#    assignment.attributes = row.to_hash.slice(*accessible_attributes)
#    assignment.save!
#  end
#end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end

  def location_address
    if self.address.blank?
      self.location.display_name
    else
      self.address
    end 
  end

  def calendar_location
    self.location.code + ' ' + self.address
  end

  def self.i18n_statuses(hash = {})
    statuses.keys.each { |key| hash[I18n.t("statuses.#{key}")] = key }
    hash
  end

  def all_day_event?
    self.start_datetime == self.start_datetime.midnight && 
    self.due_datetime == self.due_datetime.midnight ? true : false
  end

  def self.assign_task(assignment_id)
    i = Assignment.find(assignment_id)
    if i.work_code? 
      l = Location.where("code = ? ", i.location_code)
      w = Master.where(" parent_id = 2 and code = ? ", i.work_code) 
    else    
      l = i.location_id
      w = i.work_id
    end
    while Workflow.where('work_id = ? and location_id = ? ', w.id, l.id).count == 0
      l = l.parent
    end
    wf = Workflow.where('work_id = ? and location_id = ? ', w.id, l.id).first
  end

  def self.today
    where("start_datetime >= ?", Time.zone.now.beginning_of_day)
  end

  def valid_block?
    Block.new(block_data, last_record || '0').calc_hash_with_nonce(nonce) == block_hash
  end

  private

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      assignment = Assignment.new
      assignment.location = Location.where(' code = ?',  row[1]).first
      assignment.work = Master.where(' parent_id = 2 and code = ? ', row[0] ).first
      assignment.start_datetime = row[2]
      assignment.due_datetime = assignment.start_datetime + 30.minutes
      assignment.user = User.first
      assignment.save
    end
  end

  def set_no
    max_code = Assignment.maximum(:no)
    cur_year = Date.current.year - 2000 
    if max_code.to_i > cur_year * 10000
      self.no = max_code.to_i + 1
    else 
      self.no = cur_year * 100000 + 1
    end 
  end

  def own
    self.worker_user == current_user 
  end

  def assign_person_in_charge
    self.incharge_user_id = self.contractor.incharge_user_id
    self.worker_user_id ||= self.contractor.incharge_user_id
  end

  def syn_dates
      self.start_datetime ||= self.date_range[0..15]
      self.due_datetime ||= self.date_range[19..34]
  end

  def set_default_values
    if self.date_range.blank?
      self.start_datetime ||= Time.now
      self.due_datetime ||= Time.now + 30.minutes
      self.end_datetime ||= Time.now + 30.minutes
      self.color ||= 'yellow' 
    else
      self.start_datetime ||= self.date_range[0..15]
      self.due_datetime ||= self.date_range[19..34]
      self.end_datetime ||= self.date_range[19..34]
      self.color ||= 'red' 
    end
    
    if self.work_code? and self.work_id.nil?
      l = Location.where("code = ? ", self.location_code)
      # w = Master.where(" parent_id = 1 and code = ? ", self.work_code) 
      w = Master.Work(" code = ? ", self.work_code) 
    else    
      l = self.location_id
      w = self.work_id
    end
    self.location_id ||= 1 

    if self.contractor_id.blank?
      l = Location.find(self.location_id)
      w = Master.find(self.work_id)
      while ( Workflow.where('work_id = ? and location_id = ? ', w.id, l.id).count == 0          && self.contractor_id.blank? )
        if l.parent_id.blank?
          self.contractor_id = Chatroom.first.id 
        else
          l = l.parent
        end
      end
      if self.contractor_id.blank?
        wf = Workflow.where('work_id = ? and location_id = ? ', w.id, l.id).first
        self.contractor_id = wf.business_unit_id
      end 
    end 
    self.incharge_user_id = self.contractor.incharge_user_id
    self.worker_user_id ||= self.contractor.incharge_user_id
  end

  def update_location
    # update the room status to clean for releasing
    if self.completed? and self.work_id = 2
      location = Location.find(self.location_id)
      location.Clean!
      location.save
    end
    u = User.find(self.worker_user_id)
    tasks = Assignment.today.where(worker_user_id: self.worker_user_id).count
    u.today_tasks = tasks 
    u.save 
  end

  def create_notification
      Notification.create(recipient: self.worker_user, user: self.user, 
                    notifiable: self, 
        content: "#{Time.now.to_formatted_s(:db)}  #{self.work.name} Job : #{self.no} ")
  end

  def set_dates
    self.start_datetime = self.date_range[0..15].to_datetime 
    self.end_datetime = self.date_range[18..34].to_datetime 
  end

  def generate_hash

      block = if last_record
                Block.new(block_data, last_record)
              else
                Block.first(block_data)
              end
      self.block_hash = block.hash
      self.nonce = block.nonce_value
      save

  end

  def last_record
    Assignment.select(:block_hash).where('id < ?', id).last.try(:block_hash)
  end

  def block_data
    [start_datetime, due_datetime, end_datetime, aasm_state].map(&:to_s).join(' ')
  end

end

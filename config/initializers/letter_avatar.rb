LetterAvatar.setup do |config|
  config.fill_color        = 'rgba(255, 255, 255, 1)' # default is 'rgba(255, 255, 255, 0.65)'
  config.cache_base_path   = 'public/system/lets'     # default is 'public/system'
  config.colors_palette    = :google                # default is :google
  config.weight            = 300                      # default is 300
  config.annotate_position = '-0+10'                  # default is -0+5
  config.letters_count     = 2                        # default is 1
  config.pointsize         = 140                       # default is 140
end

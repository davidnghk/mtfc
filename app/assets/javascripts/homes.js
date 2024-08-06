var currentIndex = 0; // New variable to keep track of loaded viewable.

function onDocumentLoaded(lmvDoc) {
  var modelNodes = viewerApp.bubble.search(av.BubbleNode.MODEL_NODE); // 3D designs
  var sheetNodes = viewerApp.bubble.search(av.BubbleNode.SHEET_NODE); // 2D designs
  var allNodes = modelNodes.concat(sheetNodes);
  if (allNodes.length) {
    viewerApp.selectItem(allNodes[0].data);
  }

  createCustomUI(allNodes); // Create UI for Prev and Next buttons
}

function createCustomUI(allNodes) {
  // Previous button
  var prevBtn = document.getElementById('MyPrevButton');
  prevBtn.addEventListener('click', function(){
    currentIndex = currentIndex === 0 ? (allNodes.length -1) : (currentIndex - 1);
    loadModelCurrentIndex(allNodes);
  });
  // Next button
  var nextBtn = document.getElementById('MyNextButton');
  nextBtn.addEventListener('click', function(){
    currentIndex = (currentIndex + 1) % allNodes.length;
    loadModelCurrentIndex(allNodes);
  });
}

function loadModelCurrentIndex(allNodes) {
  viewerApp.selectItem(allNodes[currentIndex].data);
}
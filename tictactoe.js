
  var whose_turn = function(className) {
      return ['x', 'o'][className.split('_').filter(function(a) { return a != ''; }).length % 2]
  }
  var cells = {
      'cell zero': 0, 'cell one': 1, 'cell two': 2,
      'cell three': 3, 'cell four': 4, 'cell five': 5,
      'cell six': 6, 'cell seven': 7, 'cell eight': 8
  }
  var n, i, className
  
  // http://stackoverflow.com/questions/1431094/how-do-i-replace-a-character-at-a-particular-index-in-javascript
  String.prototype.replaceAt=function(index, character) {
      return this.substr(0, index) + character + this.substr(index+character.length);
  }
  
  for (cell in cells){
      document.getElementsByClassName(cell)[0].addEventListener('click', function(e) {
          i = cells[e.target.className]
          className = document.getElementById('board').className
          if (className[i] == '_') {
              document.getElementById('board').setAttribute('class', className.replaceAt(i, whose_turn(className)))
          }
      })
  }

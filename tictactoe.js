
  var whose_turn = function(className) {
      return ['x', 'o'][className.split('_').filter(function(a) { return a != ''; }).length % 2]
  }
  var cells = {
      'cell one': 0, 'cell two': 1, 'cell three': 2,
      'cell four': 3, 'cell five': 4, 'cell six': 5,
      'cell seven': 6, 'cell eight': 7, 'cell nine': 8
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

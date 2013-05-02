
  var whose_turn = function(className) {
      return ['x', 'o'][className.split('_').filter(function(a) { return a != ''; }).length % 2]
  }
  var clickers = {
      'clicker zero': 0, 'clicker one': 1, 'clicker two': 2,
      'clicker three': 3, 'clicker four': 4, 'clicker five': 5,
      'clicker six': 6, 'clicker seven': 7, 'clicker eight': 8
  }
  var n, i, className
  
  // http://stackoverflow.com/questions/1431094/how-do-i-replace-a-character-at-a-particular-index-in-javascript
  String.prototype.replaceAt=function(index, character) {
      return this.substr(0, index) + character + this.substr(index+character.length);
  }
  
  for (clicker in clickers){
      document.getElementsByClassName(clicker)[0].addEventListener('click', function(e) {
          i = clickers[e.target.className]
          className = document.getElementById('board').className
          if (className[i] == '_') {
              document.getElementById('board').setAttribute('class', className.replaceAt(i, whose_turn(className)))
          }
      })
  }

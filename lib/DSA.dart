//Roman to Integer
// main() {
//    // int intList = [];
//   //  String s = "MCMXCIV";
//   // String s = "III"; //3
//   String s = "LVIII"; //58
//     int sum = 0;
//     Map<String, int?> romanMap = {
//         'I':1,
//         'V':5,
//         'X':10,
//         'L':50,
//         'C':100,
//         'D':500,
//         'M':1000,
//     };

//     List<String> letters = s.split('');

// //i = 6 and len = 7
//     for(int i =0; i<letters.length; i++){
//      int  j = i+1;

//      if(j<letters.length && romanMap[letters[i]]!<romanMap[letters[j]]!){
//           sum = sum  + (romanMap[letters[j]]!- romanMap[letters[i]]!);
//           // print(sum);
//           i = i+1;
          
//     }else{
//       sum = sum + romanMap[letters[i]]!;

//     }


//     }
//     // print(sum);
//     return sum;


// }




//Longest common prefix

// main(){





// // List<String> strs = ["flower","flow","flight"];
// List<String> strs = ["dog","racecar","car"];

// String firstWord = strs[0]; //flower

// String output = "";



// for(int i = 0; i<firstWord.length; i++){


//   String letter = firstWord[i]; //f

    
//   for(int j = 1; j<strs.length; j++){
    

//     String selectedWord = strs[j];
//     // print(selectedWord);

//     if(i==selectedWord.length ||  letter!=selectedWord[i]){

      

//       // print(output);

//       return output;

//     }

    

            

//   }
//   output = '${output}$letter';
//   // print(output);
      


// }

// return output;





// }




import 'dart:collection';

///// Parentheses///////

//  main() {
//  String s = '(){}[]';

//  Map<String, String> map = {
//   '()':'()',
//   '[]':'[]',
//   '{}':'{}'
//  };

//  bool output;

//  String bracket;

// //  if( s.isEmpty){
// //   return false;
// //  }

//  for(int i = 0; i<s.length; i++){
//   print(i);

//   bracket = s[i]+s[i+1];


//   if(map.containsKey(bracket)){
//     output = true;
//     i = i+1;
//   }else{
//     output = false;
//     return output;
//   }
//   if(i==s.length/2){
//     return output;
//   }

//   return output;


//  }


// }




//  int main(){

// String s = 'Hello World ';

// List<String> words=s.trim().split(' ');
// String trimmed = s.trim();
// int output = 0 ;

// print(words);
// // print(trimmed.length);

// for (int i = trimmed.length-1 ;  i >= 0; i--){


//     output++;

//   if(trimmed[i]==' '){

//     print('White space found the output is $output');
  
//     return output-1;
//   }

  
  
  
// }
// print('The only word has an output of $output');
// return output;


// }


// int main(){

// String s = ' World ';

// List<String> words=s.trim().split(' ');
// int listLen = words.length;
// String lastWord = words[listLen-1];
// String trimmed = s.trim();


// print(words);
// // print(trimmed.length);


// // print(lastWord.length);
// return lastWord.length;


// }

int main(){
  // String s = "abcabcbb";
//  String s = "bbbbb";
// String s = "pwwkew";
String s = "pw";
// String s = 'a';
// String s = 'dvdf';
   List stringArr = s.split('');
    String store = '';
    List<int> counter = []  ;
    int count = 0;
    int largest = 0;
    
   

   if(s.isEmpty) {
    // print(0);
      return 0;
    }
     if(s==" " || s.length==1) {
    // print(0);
      return 1;
    }
    for(int i  = 0; i<stringArr.length; i++){
        if(store.contains(stringArr[i])){
          // print(i);
          //   return i;
          count = store.length; //2 
          counter.add(count);
          store = stringArr[i];
         
          // counter.add(count);
          // store = store+stringArr[i];

        }else{
          store = store +stringArr[i];
          counter.add(store.length);
        }
        
        // counter = counter++;

    }
    for(int j = 0; j<counter.length;j++){
      if(counter[j]>largest){
        largest = counter[j];
      }
    }
    print(counter);
    print(largest);
    return largest;
}
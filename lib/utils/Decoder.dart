import 'dart:convert';

class Decoder {
   static String tokenDecoder(token){
      var tokenArray = token.split('.');
      String string = tokenArray[1];

      if(string.length % 4 != 0) string = string + "00";
      String id = utf8.decode(base64.decode(string));

      List list = id.split(",");
      List<String> value;
      for(var i = 0; i < list.length; i++) {

         String s = list[i];
         value = s.split(":");
         if(value[0] == '"sub"') {
            return value[1].substring(1, value[1].length -1);

         }
      }
      return null;
   }
}
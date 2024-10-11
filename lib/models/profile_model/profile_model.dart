


class Profile {
  final int id;
  final String name;
  final String email;
  final Map<String,dynamic> tokens;


  Profile({ required this.id, required this.name,required this.email, required this.tokens});



  factory Profile.fromjson(Map<String,dynamic> projectJson){

    return Profile(

      id: projectJson['id'],
      name:  projectJson['username'],
      email: projectJson['email'],
      tokens: projectJson['tokens'],


    );
  }

}
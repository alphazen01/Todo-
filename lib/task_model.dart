class CustomerModel{
  int?id;
  String?title;
  String?description;

CustomerModel({
  this.id,
  this.title,
  this.description,
  });
  Map<String,dynamic>toMap()=>{
    "id":id,
    "title":title,
    "description":description,
  };
  factory CustomerModel.fromMap(Map<String,dynamic>data)=>CustomerModel(
    id: data["id"],
    title: data["title"],
    description: data["description"],
   
  );







}
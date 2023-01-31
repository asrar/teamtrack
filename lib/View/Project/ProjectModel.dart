class ProjectModel {
  ProjectModel({
    required this.data,
  });
  late final Data data;

  ProjectModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.projectTypeId,
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.material,
    required this.tools,
    required this.team,
    required this.expenses1,
    required this.actions1,
    required this.vehicles,
    required this.teamCost,
    required this.materialCost,
    required this.extraCost,
    required this.type,
  });
  late final int id;
  late final String projectTypeId;
  late final String name;
  late final String description;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final List<Material> material;
  late final List<Tools> tools;
  late final List<Team> team;
  late final List<Expenses1> expenses1;
  late final List<dynamic> actions1;
  late final List<dynamic> vehicles;
  late final TeamCost teamCost;
  late final MaterialCost materialCost;
  late final ExtraCost extraCost;
  late final Type type;

  Data.fromJson(Map<String, dynamic> json){
    //print("-- project data 1");
    id = json['id'];
    projectTypeId = json['project_type_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    //print("-- project data 2");
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    material = List.from(json['material']).map((e)=>Material.fromJson(e)).toList();
    //print("-- project data 2 a");
    tools = List.from(json['tools']).map((e)=>Tools.fromJson(e)).toList();
    //print("-- project data 2 b");
    //print("-- project data 3");
    team = List.from(json['team']).map((e)=>Team.fromJson(e)).toList();

    //print("-- project data 4");
    // expenses1 = List.from(json['expenses1']).map((e)=>Expenses1.fromJson(e)).toList();
    // actions1 = List.castFrom<dynamic, dynamic>(json['actions1']);
    // vehicles = List.castFrom<dynamic, dynamic>(json['vehicles']);
    // teamCost = TeamCost.fromJson(json['teamCost']);
    // materialCost = MaterialCost.fromJson(json['materialCost']);
    // extraCost = ExtraCost.fromJson(json['extraCost']);
    // type = Type.fromJson(json['type']);
    //print("-- project data 6");
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['project_type_id'] = projectTypeId;
    _data['name'] = name;
    _data['description'] = description;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['material'] = material.map((e)=>e.toJson()).toList();
    _data['tools'] = tools.map((e)=>e.toJson()).toList();
    _data['team'] = team.map((e)=>e.toJson()).toList();
    _data['expenses1'] = expenses1.map((e)=>e.toJson()).toList();
    _data['actions1'] = actions1;
    _data['vehicles'] = vehicles;
    _data['teamCost'] = teamCost.toJson();
    _data['materialCost'] = materialCost.toJson();
    _data['extraCost'] = extraCost.toJson();
    _data['type'] = type.toJson();
    return _data;
  }
}

class Material {
  Material({
    required this.id,
    required this.name,
    required this.projectId,
    required this.unitTitle,
    required this.stock,
  });
  late final int id;
  late final String name;
  late final String projectId;
  late final String unitTitle;
  late final List<Stock> stock;

  Material.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    projectId = json['project_id'];
    unitTitle = json['unit_title'];
    stock = List.from(json['stock']).map((e)=>Stock.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['project_id'] = projectId;
    _data['unit_title'] = unitTitle;
    _data['stock'] = stock.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Stock {
  Stock({
    required this.id,
    required this.materialsId,
    required this.projectId,
    required this.receivedFrom,
    required this.receivedTo,
    required this.quantity,
    required this.packageQuantity,
    required this.unitPackageId,
    this.unit,
    required this.notes,
    required this.unitpacakge,
  });
  late final int id;
  late final String materialsId;
  late final String projectId;
  late final String receivedFrom;
  late final String receivedTo;
  late final String quantity;
  late final String packageQuantity;
  late final String unitPackageId;
  late final String? unit;
  late final String notes;
  late final Unitpacakge unitpacakge;

  Stock.fromJson(Map<String, dynamic> json){
    //print("Starting Stock parsing ");
    id = json['id'];

    if(json['materials_id'] != null ) {
      materialsId = json['materials_id'];
    }else if(json['tools_id'] != null){
      materialsId = json['tools_id'];
    }
    //print("-- before quantity 11");
    projectId = json['project_id'];
    if(json['received_from']!=null) {
      receivedFrom = json['received_from'];
    }
    if(json['received_to']!=null) {
      receivedTo = json['received_to'];
    }


    quantity = json['quantity'];
    //print("-- before quantity >> ${json['package_quantity']}");
    if(json['package_quantity']!=null) {
      packageQuantity = json['package_quantity'];
    }
    if(json['unit_package_id']!=null) {
      unitPackageId = json['unit_package_id'];
    }


    //print(" >> ? before unit - inside stock");
    if(json['unit']!=null){
      //print("unit is unit. ${json['unit']}");
      unit = json['unit'];
    }
    //print("before unit - inside stock 0 ");
    if(json['notes']!=null) {
      //print(" material id ${json['materials_id']} >>>>> NEW NOTES <<<<<<<< ${json['notes']} ");
      notes = json['notes'];
    }
    //print(" >>>> before unit - inside stock 1");
    if(json['created_at'] !=null) {
 //     cr = json['created_at'];
    } //print("before unit - inside stock 2");
    if(json['updated_at']!=null) {
   //   updatedAt = json['updated_at'];
    }
    //print("End Stock parsing ");
    //print(" just before unit - inside stock");
    //print("the real unitpackage is ${json['unitpacakge']} ");
    if(json['unitpacakge']!=null) {
      unitpacakge = Unitpacakge.fromJson(json['unitpacakge']);
      //print("end unit - inside stock");
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['materials_id'] = materialsId;
    _data['project_id'] = projectId;
    _data['received_from'] = receivedFrom;
    _data['received_to'] = receivedTo;
    _data['quantity'] = quantity;
    _data['package_quantity'] = packageQuantity;
    _data['unit_package_id'] = unitPackageId;
    _data['unit'] = unit;
    _data['notes'] = notes;
    _data['unitpacakge'] = unitpacakge.toJson();
    return _data;
  }
}

class Unitpacakge {
  Unitpacakge({
    required this.id,
    required this.title,
    required this.quantity,
    required this.status,
  });
  late final int id;
  late final String title;
  late final String quantity;
  late final String status;

  Unitpacakge.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    quantity = json['quantity'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['quantity'] = quantity;
    _data['status'] = status;
    return _data;
  }
}

class Tools {
  Tools({
    required this.id,
    required this.name,
    required this.projectId,
    required this.unitTitle,
    required this.stock,
  });
  late final int id;
  late final String name;
  late final String projectId;
  late final String unitTitle;
  late final List<Stock> stock;

  Tools.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    projectId = json['project_id'];
    unitTitle = json['unit_title'];
    stock = List.from(json['stock']).map((e)=>Stock.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['project_id'] = projectId;
    _data['unit_title'] = unitTitle;
    _data['stock'] = stock.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Team {
  Team({
    required this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.image,
    required this.password,
    required this.mysurity,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    this.zoneId,
    required this.city,
    required this.cnic,
    this.authToken,
    required this.memberAddingTime,
    required this.startRollCall,
    required this.endRollcall,
  });
  late final int id;
  late final String fName;
  late final String lName;
  late final String phone;
  late final String email;
  late final String image;
  late final String password;
  late final String mysurity;
  late final Null rememberToken;
  late final String createdAt;
  late final String updatedAt;
  late final String roleId;
  late final Null zoneId;
  late final String? city;
  late final String? cnic;
  late final String? authToken;
  late final String memberAddingTime;
    StartRollCall? startRollCall;
    EndRollcall? endRollcall;

  Team.fromJson(Map<String, dynamic> json){
    //print("team 1");
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    //print("team 2");
    password = json['password'];
    mysurity = json['mysurity'];
    rememberToken = null;
    //print("team 3");
    createdAt = json['created_at'];
    //print("team 3 a - pre");
    updatedAt = json['updated_at'];
    //print("team 3 a");
    roleId = json['role_id'];
    //print("team 4");
    zoneId = null;
    //print("team 4 a 1");
    city = json['city'];
    //print("team 4 a 2");
    cnic = json['cnic'];
    //print("team 4 a");
    authToken = null;
    memberAddingTime = json['member_adding_time'];
    //print("team roll call 5");
    if(json['startRollCall']!=null){
      startRollCall = StartRollCall.fromJson(json['startRollCall']);

    }

    if(json['endRollcall']!=null){
      endRollcall = EndRollcall.fromJson(json['endRollcall']);
    }

    //print("-------ended new fresh team parsing-------------");

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['f_name'] = fName;
    _data['l_name'] = lName;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['image'] = image;
    _data['password'] = password;
    _data['mysurity'] = mysurity;
    _data['remember_token'] = rememberToken;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['role_id'] = roleId;
    _data['zone_id'] = zoneId;
    _data['city'] = city;
    _data['cnic'] = cnic;
    _data['auth_token'] = authToken;
    _data['member_adding_time'] = memberAddingTime;
    _data['startRollCall'] = startRollCall!.toJson();
    _data['endRollcall'] = endRollcall!.toJson();

    return _data;
  }
}
class StartRollCall {
  StartRollCall({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.actor1,
    required this.actor1Id,
    required this.actor2,
    required this.actor2Id,
    required this.item1,
    required this.item1Id,
    required this.item2,
    required this.item2Id,
    required this.quantity,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String type;
  late final String title;
  late final String description;
  late final String actor1;
  late final String actor1Id;
  late final String actor2;
  late final String actor2Id;
  late final String item1;
  late final String item1Id;
  late final String item2;
  late final String item2Id;
  late final String quantity;
  late final String level;
  late final String? createdAt;
  late final String? updatedAt;

  StartRollCall.fromJson(Map<String, dynamic> json){
    //print("start roll call 1");
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    actor1 = json['actor1'];
    actor1Id = json['actor1_id'];
    //print("start roll call 2");
    actor2 = json['actor2'];
    actor2Id = json['actor2_id'];
    //print("start roll call 3");
    if(json['item1']!=null) {
      item1 = json['item1']!; //null;
    }
    if(json['item1_id']!=null){
      item1Id = json['item1_id']!;
    }
    if(json['item2']!=null){
      item2 = json['item2']!;
    }
    if(json['item2_id']!=null){
      item2Id = json['item2_id']!;
    }
    // null;


    //print("start roll call 4");
    if(json['quantity']!= null){
      quantity = json['quantity']!;
    }
     //;
    if(json['level']!=null){
      level = json['level']!; //null;
    }

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    //print("start roll call 5 end");
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['title'] = title!;
    _data['description'] = description!;
    _data['actor1'] = actor1!;
    _data['actor1_id'] = actor1Id!;
    _data['actor2'] = actor2!;
    _data['actor2_id'] = actor2Id!;
    _data['item1'] = item1!;
    _data['item1_id'] = item1Id!;
    _data['item2'] = item2!;
    _data['item2_id'] = item2Id!;
    _data['quantity'] = quantity!;
    _data['level'] = level!;
    _data['created_at'] = createdAt!;
    _data['updated_at'] = updatedAt!;
    return _data;
  }
}

class EndRollcall {
  EndRollcall({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.actor1,
    required this.actor1Id,
    required this.actor2,
    required this.actor2Id,
    required this.item1,
    required this.item1Id,
    required this.item2,
    required this.item2Id,
    required this.quantity,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String type;
  late final String title;
  late final String description;
  late final String actor1;
  late final String actor1Id;
  late final String actor2;
  late final String actor2Id;
  late final String item1;
  late final String item1Id;
  late final String item2;
  late final String item2Id;
  late final String quantity;
  late final String level;
  late final String createdAt;
  late final String updatedAt;

  EndRollcall.fromJson(Map<String, dynamic> json){
    //print("end roll call 0");
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    actor1 = json['actor1'];
    actor1Id = json['actor1_id'];
    //print("end roll call 0 1");
    actor2 = json['actor2'];
    actor2Id = json['actor2_id'];
    if(json['item1']!=null)
    {
      item1 = json['item1'];
    }
    //print("end roll call 2");
    if(json['item1_id'] !=null){
      item1Id = json['item1_id'];
    }

    if(json['item2']!=null) {
      item2 = json['item2'];
    }

    if(json['item2_id'] !=null)
    {
      item2Id = json['item2_id'];
    }

    //print("end roll call 3--");
    if(json['quantity']!=null) {
      quantity = json['quantity'];
    }
    if(json['level']!=null) {
      level = json['level'];
    }
    //print("end roll call pre 4");
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    //print("end roll call 4");
    //print("-- end call 100");
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type!;
    _data['title'] = title!;
    _data['description'] = description!;
    _data['actor1'] = actor1!;
    _data['actor1_id'] = actor1Id!;
    _data['actor2'] = actor2!;
    _data['actor2_id'] = actor2Id!;
    _data['item1'] = item1!;
    _data['item1_id'] = item1Id!;
    _data['item2'] = item2!;
    _data['item2_id'] = item2Id!;
    _data['quantity'] = quantity!;
    _data['level'] = level!;
    _data['created_at'] = createdAt!;
    _data['updated_at'] = updatedAt!;
    return _data;
  }
}

class Expenses1 {
  Expenses1({
    required this.id,
    this.fromId,
    required this.userId,
    required this.projectId,
    required this.title,
    required this.reason,
    required this.cost,
    required this.detail,
    required this.fromSide,
    required this.fName,
    required this.lName,
  });
  late final int id;
  late final Null fromId;
  late final String userId;
  late final String projectId;
  late final String title;
  late final String reason;
  late final String cost;
  late final String detail;
  late final String fromSide;
  late final String fName;
  late final String lName;

  Expenses1.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fromId = null;
    userId = json['user_id'];
    projectId = json['project_id'];
    title = json['title'];
    reason = json['reason'];
    cost = json['cost'];
    detail = json['detail'];
    fromSide = json['from_side'];
    fName = json['f_name'];
    lName = json['l_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['from_id'] = fromId;
    _data['user_id'] = userId;
    _data['project_id'] = projectId;
    _data['title'] = title;
    _data['reason'] = reason;
    _data['cost'] = cost;
    _data['detail'] = detail;
    _data['from_side'] = fromSide;
    _data['f_name'] = fName;
    _data['l_name'] = lName;
    return _data;
  }
}

class TeamCost {
  TeamCost({
    required this.team,
    required this.totalCost,
  });
  late final List<Team> team;
  late final int totalCost;

  TeamCost.fromJson(Map<String, dynamic> json){
    team = List.from(json['team']).map((e)=>Team.fromJson(e)).toList();
    totalCost = json['totalCost'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['team'] = team.map((e)=>e.toJson()).toList();
    _data['totalCost'] = totalCost;
    return _data;
  }
}

class MaterialCost {
  MaterialCost({
    required this.materials,
    required this.totalCost,
  });
  late final List<Materials> materials;
  late final int totalCost;

  MaterialCost.fromJson(Map<String, dynamic> json){
    materials = List.from(json['materials']).map((e)=>Materials.fromJson(e)).toList();
    totalCost = json['totalCost'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['materials'] = materials.map((e)=>e.toJson()).toList();
    _data['totalCost'] = totalCost;
    return _data;
  }
}

class Materials {
  Materials({
    required this.id,
    required this.perUnitPrice,
    required this.name,
    required this.projectId,
    required this.unitTitle,
    required this.stock,
    required this.cost,
  });
  late final int id;
  late final String perUnitPrice;
  late final String name;
  late final String projectId;
  late final String unitTitle;
  late final String stock;
  late final int cost;

  Materials.fromJson(Map<String, dynamic> json){
    id = json['id'];
    perUnitPrice = json['per_unit_price'];
    name = json['name'];
    projectId = json['project_id'];
    unitTitle = json['unit_title'];
    stock = json['stock'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['per_unit_price'] = perUnitPrice;
    _data['name'] = name;
    _data['project_id'] = projectId;
    _data['unit_title'] = unitTitle;
    _data['stock'] = stock;
    _data['cost'] = cost;
    return _data;
  }
}

class ExtraCost {
  ExtraCost({
    required this.detail,
    required this.expenses,
    required this.cost,
  });
  late final List<Detail> detail;
  late final List<Expenses> expenses;
  late final int cost;

  ExtraCost.fromJson(Map<String, dynamic> json){
    detail = List.from(json['detail']).map((e)=>Detail.fromJson(e)).toList();
    expenses = List.from(json['expenses']).map((e)=>Expenses.fromJson(e)).toList();
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['detail'] = detail.map((e)=>e.toJson()).toList();
    _data['expenses'] = expenses.map((e)=>e.toJson()).toList();
    _data['cost'] = cost;
    return _data;
  }
}

class Detail {
  Detail({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.actor1,
    required this.actor1Id,
    this.actor2,
    required this.actor2Id,
    this.item1,
    required this.item1Id,
    required this.item2,
    required this.item2Id,
    required this.quantity,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String type;
  late final String title;
  late final String description;
  late final String actor1;
  late final String actor1Id;
  late final Null actor2;
  late final String actor2Id;
  late final Null item1;
  late final String item1Id;
  late final String item2;
  late final String item2Id;
  late final String quantity;
  late final String level;
  late final String createdAt;
  late final String updatedAt;

  Detail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    actor1 = json['actor1'];
    actor1Id = json['actor1_id'];
    actor2 = null;
    actor2Id = json['actor2_id'];
    item1 = null;
    item1Id = json['item1_id'];
    item2 = json['item2'];
    item2Id = json['item2_id'];
    quantity = json['quantity'];
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['title'] = title;
    _data['description'] = description;
    _data['actor1'] = actor1;
    _data['actor1_id'] = actor1Id;
    _data['actor2'] = actor2;
    _data['actor2_id'] = actor2Id;
    _data['item1'] = item1;
    _data['item1_id'] = item1Id;
    _data['item2'] = item2;
    _data['item2_id'] = item2Id;
    _data['quantity'] = quantity;
    _data['level'] = level;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Expenses {
  Expenses({
    required this.id,
    this.fromId,
    required this.userId,
    required this.projectId,
    required this.title,
    required this.reason,
    required this.cost,
    required this.detail,
    required this.fromSide,
  });
  late final int id;
  late final Null fromId;
  late final String userId;
  late final String projectId;
  late final String title;
  late final String reason;
  late final String cost;
  late final String detail;
  late final String fromSide;

  Expenses.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fromId = null;
    userId = json['user_id'];
    projectId = json['project_id'];
    title = json['title'];
    reason = json['reason'];
    cost = json['cost'];
    detail = json['detail'];
    fromSide = json['from_side'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['from_id'] = fromId;
    _data['user_id'] = userId;
    _data['project_id'] = projectId;
    _data['title'] = title;
    _data['reason'] = reason;
    _data['cost'] = cost;
    _data['detail'] = detail;
    _data['from_side'] = fromSide;
    return _data;
  }
}

class Type {
  Type({
    required this.id,
    required this.name,
    required this.activities,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.myActivities,
  });
  late final int id;
  late final String name;
  late final List<String> activities;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final List<String> myActivities;

  Type.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    activities = List.castFrom<dynamic, String>(json['activities']);
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    myActivities = List.castFrom<dynamic, String>(json['myActivities']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['activities'] = activities;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['myActivities'] = myActivities;
    return _data;
  }
}
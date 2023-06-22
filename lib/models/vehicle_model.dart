class VehicleModel {
  final int id;
  final String name;
  final String model;

  const VehicleModel({
    required this.name,
    required this.id,
    required this.model,
  });
}

final List<VehicleModel> vehicleList = [
  const VehicleModel(
    name: "Toyota",
    model: "Model 1",
    id: 101,
  ),
  const VehicleModel(
    name: "BMW",
    model: "Model 2",
    id: 102,
  ),
  const VehicleModel(
    name: "Audi",
    model: "Model 3",
    id: 103,
  ),
];

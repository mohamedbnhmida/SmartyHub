class ApiRoutes {
 static const String baseUrl = 'http://148.113.193.96/Coriolis.RentCars.WebApi';
  //static const String baseUrl = 'https://localhost:7043';

  static const String getUserbyEmail = '/api/users/email/{email}';
  static const String login = '/api/token/generate';
  static const String register = '/api/users/register';
  static const String getUsers = '/api/users';

  static const String getClients = '/api/v1/clients';
  static const String getVehicule = '/api/v1/vehicules/{id}';
  static const String getVehiculesList = '/api/v1/vehicules';
  static const String saveVehicule = '/api/v1/vehicules';
  static const String deleteVehicule = '/api/v1/vehicules/{id}';

  static const String getCouleurList = '/api/v1/couleurs';
  static const String getCouleur = '/api/v1/couleurs/{id}';
  static const String saveCouleur = '/api/v1/couleurs';
  static const String deleteCouleur = '/api/v1/couleurs/{id}';

  static const String getFamilleClientList = '/api/v1/famille-clients';
  static const String getFamilleClient = '/api/v1/famille-clients/{id}';
  static const String saveFamilleClient = '/api/v1/famille-clients';
  static const String deleteFamilleClient = '/api/v1/famille-clients/{id}';

  static const String getMarqueList = '/api/v1/marques';
  static const String getMarque = '/api/v1/marques/{id}';
  static const String saveMarque = '/api/v1/marques';
  static const String deleteMarque = '/api/v1/marques/{id}';

  static const String getTypeBoiteVitesseList = '/api/v1/type-boite-vitesses';
  static const String getTypeBoiteVitesse = '/api/v1/type-boite-vitesses/{id}';
  static const String saveTypeBoiteVitesse = '/api/v1/type-boite-vitesses';
  static const String deleteTypeBoiteVitesse =
      '/api/v1/type-boite-vitesses/{id}';

  static const String getTypeCarburantList = '/api/v1/type-carburants';
  static const String getTypeCarburant = '/api/v1/type-carburants/{id}';
  static const String saveTypeCarburant = '/api/v1/type-carburants';
  static const String deleteTypeCarburant = '/api/v1/type-carburants/{id}';

  static const String getModelList = '/api/v1/modeles?idMarque=';
  static const String getModel = '/api/v1/modeles/{id}/{id}';
  static const String saveModel = '/api/v1/modeles';
  static const String deleteModel = '/api/v1/modeles/{id}/{id}';

  static const String getCommercialList = '/api/v1/commercials';
  static const String getCommercial = '/api/v1/commercials/{id}';
  static const String saveCommercial = '/api/v1/commercials';
  static const String deleteCommercial = '/api/v1/commercials/{id}';

  static const String getReservations = '/api/v1/reservations';

  static const String getClientList = '/api/v1/clients';
  static const String getClient = '/api/v1/clients/{id}';
  static const String saveClient = '/api/v1/clients';
  static const String deleteClient = '/api/v1/clients/{id}';

  static const String getChauffeurList = '/api/v1/chauffeurs';
  static const String getChauffeur = '/api/v1/chauffeurs/{id}';
  static const String saveChauffeur = '/api/v1/chauffeurs';
  static const String deleteChauffeur = '/api/v1/chauffeurs/{id}';
}

class Account {

  //classe responsável por representar uma conta de banco dos clientes

  //propriedades:
  String name;
  double balance;
  bool isAuthenticated;
  DateTime? createdAt;

  //construtor:
  Account( { required this.name, required this.balance, required this.isAuthenticated, this.createdAt } );

  //método para editar saldo:
  editBalance({required value}) {
    balance = balance + value;
  }

}
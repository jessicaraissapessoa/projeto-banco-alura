import 'dart:math';

import 'controllers/bank_controller.dart';
import 'exceptions/bank_controller_exceptions.dart';
import 'models/Account.dart';

void testingNullSafety() {
  Account? myAccount = Account(name: 'Ricarth', balance: 200, isAuthenticated: true);

  //Simulando uma comunicação externa
  Random rng = Random();

  int randomNumber = rng.nextInt(10); // entre () o máximo que recebe: no caso vai de 0 a 10

  if (randomNumber <= 5) {
    myAccount.createdAt = DateTime.now();
  }

  print(myAccount.runtimeType);
  print(myAccount.createdAt);

  //print(myAccount!.balance); teste forçando conversão. não seguro. má prática

  //forma segura de resolver:
  if(myAccount != null) {
    print(myAccount.balance);

    if (myAccount.createdAt != null) {
      print(myAccount.createdAt!.day);
    }
  } else {
    print("Conta nula");
  }

  //forma segura de resolver com operador ternário:
  print(myAccount != null ? myAccount.balance : "Conta nula");

  //forma mais curta e segura de resolver (safe call) - chamada segura
  print(myAccount?.balance); //se não for nulo exibe balance, se for, printa null

}

void main() {

  testingNullSafety();


  //Criação do banco

  BankController bankController = BankController();


  //Criação de contas

  bankController.addAccount(
      id: "Ricarth",
      account: Account(name: "Ricarth Lima", balance: 400, isAuthenticated: true)
  );

  bankController.addAccount(
      id: "Kako",
      account: Account(name: "Caio Couto", balance: 600, isAuthenticated: true)
  );


  //Efetuando transferência

  try {

    bool result = bankController.makeTransfer(
        idSender: "Kako", idReceiver: "Ricarth", amount: 50);

    if(result) {
      print("Transação concluída com sucesso");
    }

  } on SenderIdInvalidException catch (e) {
    print(e);
    print("O ID '${e.idSender}' do remetente não é um ID válido");

  } on ReceiverIdInvalidException catch (e) {
    print(e);
    print("O ID '${e.idReceiver}' do destinatário não é um ID válido");

  } on SenderNotAuthenticatedException catch (e) {
    print(e);
    print("O usuário remetente de ID '${e.idSender}' não está autenticado");

  } on ReceiverNotAuthenticatedException catch (e) {
    print(e);
    print("O usuário destinatário de ID '${e.idReceiver}' não está autenticado");

  } on SenderBalanceLowerThanamountException catch (e) {
    print(e);
    print("O usuário de ID '${e.idSender}' tentou enviar ${e.amount} reais. No entanto, sua conta possui saldo de ${e.senderBalance} reais");

  } on Exception {
    print("Algo deu errado");
  }


}
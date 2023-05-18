import 'controllers/bank_controller.dart';
import 'exceptions/bank_controller_exceptions.dart';
import 'models/Account.dart';

void main() {


  assert(2 < 1, "Levantei o Assert");

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

  } on SenderBalanceLowerThanamountException catch (e) {
    print(e);
    print("O usuário de ID '${e.idSender}' tentou enviar ${e.amount} reais. No entanto, sua conta possui saldo de ${e.senderBalance} reais");

  } on Exception {
    print("Algo deu errado");
  }


}
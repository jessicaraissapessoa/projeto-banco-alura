import '../exceptions/bank_controller_exceptions.dart';
import '../models/Account.dart';

class BankController {

  //classe responsável por gerenciar conta e fazer as transações entre elas

  final Map <String, Account> _database = {}; //Armazenamento da instância do "banco de dados" que gerencia contas cadastradas

  //construtor de adição de conta:
  addAccount( { required String id, required Account account } ) { _database[id] = account;}




  //Método de verificação de id:
  bool verifyId (String id) {
    return _database.containsKey(id);
  }




  //método para transação bancária entre duas contas com verificações (validade de IDs, autenticação dos usuários, saldo disponível etc)
  bool makeTransfer ( { required String idSender, required String idReceiver, required double amount } ) {

    //verificação se ID de remetente é válido
    if (!verifyId(idSender)) {
      throw SenderIdInvalidException(idSender: idSender);
    }


    //verificação se ID de destinatário é válido
    if (!verifyId(idReceiver)) {
      throw ReceiverIdInvalidException(idReceiver: idReceiver);
    }

    //Se IDs passam pela verificação, pega suas instâncias no banco de dados
    Account accountSender = _database[idSender]!;
    Account accountReceiver = _database[idReceiver]!;

    //verificação se remetente está autenticado
    if (!accountSender.isAuthenticated) {
      throw SenderNotAuthenticatedException(idSender: idSender);
    }

    //Verificação se remetente possui saldo suficiente
    if (accountSender.balance < amount) {
      throw SenderBalanceLowerThanamountException(idSender: idSender, senderBalance: accountSender.balance, amount: amount);
    }

    //Se todas as verificações forem verdadeiras, efetuação da operação
    accountSender.balance -= amount;
    accountReceiver.balance += amount;

    return true;

  }

}
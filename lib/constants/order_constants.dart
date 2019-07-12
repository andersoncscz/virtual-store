class OrderStatus {
  static int inProgress = 1;
  static int dispatched = 2;
  static int delivered = 3;

  static Map<int, String> statusMap = {
    inProgress: 'Preparação',
    dispatched: 'Enviado',
    delivered: 'Entregue',
  };

}
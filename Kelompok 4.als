sig Text {}
sig EncryptedText {}

sig User {
  id: one Text,
  nama: one Text,
  alamat: one Text,
  credential: one Login
}

sig Login {
  username: Text,
  password: EncryptedText
}

sig Product {
  id: Text,
  namaItem: Text,
  harga: Int
}

sig Order {
  user: User,
  listOfProducts: some Product,
 payment: one Payment,
}

sig Cart{
listOfProducts: some Product,
}

sig Payment{
paymentType: Text,
amount: Int,
paymentID: Text,
}

sig PaymentService{
order: Order
}

sig LoginService{
login: Login
}

pred ValidOrderUser[o: Order] {
  o.user in User
}

pred ValidCartItems[c: Cart] {
  all p: c.listOfProducts | p in Product
}

pred ValidPaymentService[ps: PaymentService] {
  ps.order in Order
}

pred ValidLoginService[ls: LoginService] {
  ls.login in Login
}

pred ValidPayment[p: Payment] {
  p in Payment
}

pred ValidOrderItems[o: Order] {
  all p: o.listOfProducts | p in Product
}

pred ValidOrderPayment[o: Order] {
  o.payment in Payment
}

pred ValidUserCredential[u: User] {
  u.credential in Login
}

run {} for 5 but 3 Int, 5 Text, 3 EncryptedText


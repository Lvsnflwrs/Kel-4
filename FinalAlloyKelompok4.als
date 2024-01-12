sig Text {}
sig EncryptedText {}

sig User {
id: one Text,
nama: one Text,
alamat: one Text,
}

sig Login {
profile: User,
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
}

sig Cart{
listOfProducts: some Product,
}

sig Payment{
paymentType: Text,
amount: Int,
paymentID: Text,
service: PaymentService,
}

sig EWallet extends Payment{
PhoneNumber: Text,
}

sig CreditCard extends Payment{
CardNumber: Text,
ExpiredDate: Text,	
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

fact {
  some u: User | u.id != none and u.nama != none and u.alamat != none
  some l: Login | l.profile in User and l.username != none and l.password != none
  some p: Product | p.id != none and p.namaItem != none and p.harga >= 0
  some o: Order | o.user != none and o.listOfProducts != none
  some c: Cart | c.listOfProducts != none
  some ps: PaymentService | ps.order != none
  some pay: Payment | pay.paymentType != none and pay.amount >= 0 and pay.paymentID != none and pay.service in PaymentService
  some ew: EWallet | ew.PhoneNumber != none and ew.paymentType != none and ew.amount >= 0 and ew.paymentID != none and ew.service in PaymentService
  some cc: CreditCard | cc.CardNumber != none and cc.ExpiredDate != none and cc.paymentType != none and cc.amount >= 0 and cc.paymentID != none and cc.service in PaymentService
  some ls: LoginService | ls.login != none
}

assert UserHasUniqueID {
  all disj u1, u2: User | u1.id != u2.id
}
assert LoginHasUniqueUsername {
  all disj l1, l2: Login | l1.username != l2.username
}
assert OrderHasNonEmptyProductList {
  all o: Order | o.listOfProducts != none
}
assert PaymentAmountNonNegative {
  all pay: Payment | pay.amount >= 0
}
assert OrderHasUserAndProducts {
  all o: Order | o.user != none and o.listOfProducts != none
}
assert PaymentServiceOrderNotNull {
  all ps: PaymentService | ps.order != none
}
assert PaymentServiceHasOrder {
  all ps: PaymentService | ps.order in Order
}
assert PaymentHasService {
  all pay: Payment | pay.service in PaymentService
}
assert CreditCardIsPayment {
  all cc: CreditCard | cc in Payment
}
assert EWalletIsPayment {
  all ew: EWallet | ew in Payment
}
assert OrderWithoutUser {
  all o: Order | o.user != none
}
assert NegativePaymentAmount {
  all pay: Payment | pay.amount >= 0
}
assert PaymentServiceWithNullOrder {
  all ps: PaymentService | ps.order != none
}

run {} for 5 but 3 Int, 5 Text, 3 EncryptedText
//check UserHasUniqueID for 2
// check LoginHasUniqueUsername for 2
//check CartHasUniqueProducts for 2
//check OrderHasNonEmptyProductList for 2
//check PaymentAmountNonNegative for 2
//check OrderHasUserAndProducts for 2
//check PaymentServiceOrderNotNull for 2
// check OrderWithoutUser for 2
// check NegativePaymentAmount for 2
// check PaymentServiceWithNullOrder for 2





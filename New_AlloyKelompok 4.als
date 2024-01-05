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

// Fakta
fact {
  // Menambahkan beberapa instansiasi untuk memenuhi kriteria
  some u: User | u.id != none and u.nama != none and u.alamat != none and u.credential != none
  some l: Login | l.username != none and l.password != none
  some p: Product | p.id != none and p.namaItem != none and p.harga >= 0
  some o: Order | o.user != none and o.listOfProducts != none and o.payment != none
  some c: Cart | c.listOfProducts != none
  some ps: PaymentService | ps.order != none
  some pay: Payment | pay.paymentType != none and pay.amount >= 0 and pay.paymentID != none
  some ls: LoginService | ls.login != none
}

// Aserttion
assert UserHasID {
  // Setiap pengguna memiliki ID yang unik
  all disj u1, u2: User | u1.id != u2.id
}

assert ProductHasID {
  // Setiap produk memiliki ID yang unik
  all disj p1, p2: Product | p1.id != p2.id
}

assert OrderHasUser {
  // Setiap pesanan terkait dengan pengguna
  all o: Order | o.user in User
}

assert OrderHasProducts {
  // Setiap pesanan memiliki setidaknya satu produk
  all o: Order | o.listOfProducts != none
}

assert PaymentServiceHasOrder {
  // Setiap layanan pembayaran terkait dengan satu pesanan
  all ps: PaymentService | ps.order in Order
}

assert CartHasProducts {
  // Setiap keranjang memiliki setidaknya satu produk
  all c: Cart | c.listOfProducts != none
}



run {} for 5 but 3 Int, 5 Text, 3 EncryptedText
// check UserHasID for 2
// check ProductHasID for 2
// heck OrderHasUser for 2
// check OrderHasProducts for 2
// check PaymentServiceHasOrder for 2
// check CartHasProducts for 2





import 'package:template/src/pages/export.dart';

final List<Category> catefories = [
  Category(
    height: AppSize.s160,
    title: 'Food',
    decription: 'Order food you love',
    img: MediaRes.img1,
    bottom: AppSize.s16,
  ),
  Category(
    height: AppSize.s160,
    title: 'Grocery',
    decription: 'Shop daily life items',
    img: MediaRes.img3,
    right: AppSize.s8,
  ),
  Category(
    height: AppSize.s160,
    title: 'Deserts',
    decription: 'Something Sweet',
    img: MediaRes.img2,
    left: AppSize.s8,
  ),
];

const List<String> imgList = [
  MediaRes.sale1,
  MediaRes.sale2,
  MediaRes.sale3,
];

final List<Item> dealsHome = [
  // Item(
  //   id: '1',
  //   height: AppSize.s160,
  //   title: 'Jean’s Cakes',
  //   address: 'Johar Town',
  //   img: MediaRes.img4,
  //   isLike: false,
  //   isMoney: false,
  //   rate: 4.0,
  //   value: '40',
  //   unit: 'min',
  //   isTypeTime: true,
  // ),
  // Item(
  //   id: '2',
  //   height: AppSize.s160,
  //   title: 'Thicc Shakes',
  //   address: 'Wapda Town',
  //   img: MediaRes.img6,
  //   isLike: false,
  //   isMoney: false,
  //   rate: 4.5,
  //   value: '20',
  //   unit: 'min',
  //   isTypeTime: true,
  // ),
  // Item(
  //   id: '3',
  //   height: AppSize.s160,
  //   title: 'Daily Deli',
  //   address: 'Garden Town',
  //   img: MediaRes.img5,
  //   isLike: false,
  //   isMoney: false,
  //   rate: 4.8,
  //   value: '30',
  //   unit: 'min',
  //   isTypeTime: true,
  // ),
];

const dataRestaurant = {
  "Popular": [
    Food(
      id: '61',
      price: 24,
      foodName: 'Chicken Fajita Pizza',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img9,
      quanity: 1,
    ),
    Food(
      id: '51',
      price: 12,
      foodName: 'Chicken Fajita Pizza',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img8,
      quanity: 0,
    ),
  ],
  "Deals": [
    Food(
      id: '41',
      price: 12,
      foodName: 'Deal 1',
      description: '1 regular burger with croquette and hot cocoa',
      image: MediaRes.img10,
      quanity: 0,
    ),
    Food(
      id: '31',
      price: 6,
      foodName: 'Deal 2',
      description: '2 regular burger with croquette and hot cocoa',
      image: MediaRes.img11,
      quanity: 0,
    ),
    Food(
      id: '21',
      price: 45,
      foodName: 'Deal 3',
      description: '2 pieces of beef stew with homemade sauce',
      image: MediaRes.img8,
      quanity: 0,
    ),
  ],
  "Wraps": [
    Food(
      id: '10',
      price: 8,
      foodName: 'Wraps 1',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img4,
      quanity: 0,
    ),
    Food(
      id: '19',
      price: 5,
      foodName: 'Wraps 2',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img12,
      quanity: 0,
    ),
    Food(
      id: '1',
      price: 2,
      foodName: 'Wraps 3',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img6,
      quanity: 0,
    ),
    Food(
      id: '91',
      price: 12,
      foodName: 'Wraps 4',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img13,
      quanity: 0,
    ),
  ],
  "Beverages": [
    Food(
      id: '17',
      price: 13,
      foodName: 'Beverages 1',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img4,
      quanity: 0,
    ),
    Food(
      id: '18',
      price: 5,
      foodName: 'Beverages 2',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img5,
      quanity: 0,
    ),
  ],
  "Sandwiches": [
    Food(
      id: '16',
      price: 23,
      foodName: 'Sandwiches 1',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img1,
      quanity: 0,
    ),
    Food(
      id: '15',
      price: 12,
      foodName: 'Sandwiches 2',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img2,
      quanity: 0,
    ),
  ],
  "Sandwiches 3": [
    Food(
      id: '14',
      price: 23,
      foodName: 'Sandwiches 1',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img1,
      quanity: 0,
    ),
    Food(
      id: '11',
      price: 12,
      foodName: 'Sandwiches 2',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img2,
      quanity: 0,
    ),
  ],
  "Sandwiches 5": [
    Food(
      id: '12',
      price: 23,
      foodName: 'Sandwiches 1',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img1,
      quanity: 0,
    ),
    Food(
      id: '3',
      price: 12,
      foodName: 'Sandwiches 2',
      description: '8” pizza with regular soft drink',
      image: MediaRes.img2,
      quanity: 0,
    ),
  ]
};
const FoodType foodType1 = FoodType(typeId: '1', typeName: '8”', typePrice: 10);
const FoodType foodType2 =
    FoodType(typeId: '2', typeName: '10”', typePrice: 12);
const FoodType foodType3 =
    FoodType(typeId: '3', typeName: '12”', typePrice: 16);

const FoodExtra foodExtra1 =
    FoodExtra(extraId: '1', extraName: 'Texas Barbeque', extraPrice: 6);
const FoodExtra foodExtra2 =
    FoodExtra(extraId: '2', extraName: 'Char Donay', extraPrice: 8);

const FoodInfo foodOrderInfo = FoodInfo(
    type: [foodType1, foodType2, foodType3],
    quanity: 1,
    note: '',
    extra: [foodExtra1, foodExtra2],
    totalPrice: 0,
    name: 'Chicken Fajita Pizza',
    address: 'Daily Deli - Johar Town',
    isFavourite: false,
    image: MediaRes.img1);

final List<FoodStatus> foodOptions = [
  FoodStatus(label: 'Remove it from my order', value: 0)
];

final List<Food> cart = [
  const Food(
    id: '61',
    price: 24,
    foodName: 'Chicken Fajita Pizza',
    description: '8” pizza with regular soft drink',
    image: MediaRes.img9,
    quanity: 1,
  ),
  const Food(
    id: '51',
    price: 12,
    foodName: 'Chicken Fajita Pizza',
    description: '8” pizza with regular soft drink',
    image: MediaRes.img8,
    quanity: 3,
  ),
  const Food(
    id: '51',
    price: 12,
    foodName: 'Chicken Fajita Pizza',
    description: '8” pizza with regular soft drink',
    image: MediaRes.img8,
    quanity: 2,
  ),
  const Food(
    id: '61',
    price: 24,
    foodName: 'Chicken Fajita Pizza',
    description: '8” pizza with regular soft drink',
    image: MediaRes.img9,
    quanity: 1,
  ),
  const Food(
    id: '51',
    price: 12,
    foodName: 'Chicken Fajita Pizza',
    description: '8” pizza with regular soft drink',
    image: MediaRes.img8,
    quanity: 3,
  ),
];

final List<Item> popularFood = [
  Item(
    id: 1,
    height: AppSize.s160,
    title: 'Jean’s Cakes',
    address: 'Johar Town',
    img: MediaRes.img4,
    isLike: false,
    isMoney: false,
    rate: 4.0,
    value: 40,
    unit: '\$',
    isTypeTime: false,
  ),
  Item(
    id: 2,
    height: AppSize.s160,
    title: 'Thicc Shakes',
    address: 'Wapda Town',
    img: MediaRes.img6,
    isLike: false,
    isMoney: false,
    rate: 4.5,
    value: 20,
    unit: '\$',
    isTypeTime: false,
  ),
  Item(
    id:2,
    height: AppSize.s160,
    title: 'Daily Deli',
    address: 'Garden Town',
    img: MediaRes.img5,
    isLike: false,
    isMoney: false,
    rate: 4.8,
    value: 30,
    unit: '\$',
    isTypeTime: false,
  ),
];

final List<CardPay> cards = [
  const CardPay('370000000000002', 'John Doe', MediaRes.card1),
  const CardPay('370000000000003', 'John Doe 1', MediaRes.card2),
  const CardPay('370000000000004', 'John Doe 2', MediaRes.card3),
  const CardPay('370000000000005', 'John Doe 3', MediaRes.card4),
];

final List<OrderSummary> orderSummary = [
  const OrderSummary('Chicken Fajita Pizza', 20, 1),
  const OrderSummary('Chicken Wrap Deluxe', 10, 2),
  const OrderSummary('Sandwiches 1', 10, 3),
  const OrderSummary('Sandwiches 2', 8, 1),
];

final List<Item> saves = [
  Item(
    id: 1,
    height: AppSize.s160,
    title: 'Jean’s Cakes',
    address: 'Johar Town',
    img: MediaRes.img4,
    isLike: true,
    isMoney: false,
    rate: 4.0,
    value: 40,
    unit: 'min',
    isTypeTime: true,
  ),
  Item(
    id: 2,
    height: AppSize.s160,
    title: 'Thicc Shakes',
    address: 'Wapda Town',
    img: MediaRes.img6,
    isLike: true,
    isMoney: false,
    rate: 4.5,
    value:20,
    unit: 'min',
    isTypeTime: true,
  ),
  Item(
    id:4,
    height: AppSize.s160,
    title: 'Daily Deli',
    address: 'Garden Town',
    img: MediaRes.img5,
    isLike: true,
    isMoney: false,
    rate: 4.8,
    value: 30,
    unit: 'min',
    isTypeTime: true,
  ),
];

final List<Notifiacation> notifications = [
  Notifiacation(
      content: 'Your order has arrived',
      time: DateTime.parse('2024-01-20 20:18:04Z'),
      isRead: false,
      description: ''),
  Notifiacation(
      content: 'Your order is on its way',
      time: DateTime.parse('2024-05-06 00:00:04Z'),
      isRead: true,
      description: ''),
  Notifiacation(
      content: 'Your order has been placed',
      time: DateTime.parse('2024-05-01 20:18:04Z'),
      isRead: true,
      description: ''),
  Notifiacation(
      content: 'Your order has arrived',
      time: DateTime.parse('2024-01-20 20:18:04Z'),
      isRead: true,
      description: ''),
  Notifiacation(
      content: 'Confirm your phone number',
      time: DateTime.parse('2024-01-20 20:18:04Z'),
      isRead: true,
      description: ''),
  Notifiacation(
      content: 'We have updated our Privacy Policy',
      time: DateTime.parse('2024-01-20 20:18:04Z'),
      isRead: true,
      description: 'View Privacy Policy'),
  Notifiacation(
      content: 'Your order has been cancelled',
      time: DateTime.parse('2024-01-20 20:18:04Z'),
      isRead: true,
      description: ''),
  Notifiacation(
      content: 'Your order has arrived',
      time: DateTime.parse('2024-01-20 20:18:04Z'),
      isRead: true,
      description: ''),
  Notifiacation(
      content: 'Your order has been placed',
      time: DateTime.parse('2024-01-20 20:18:04Z'),
      isRead: true,
      description: ''),
  Notifiacation(
      content: 'Welcome to Foodeck',
      time: DateTime.parse('2024-01-20 20:18:04Z'),
      isRead: true,
      description: 'Watch our video'),
];

final List<FoodRecentOrder> foodRecentOrders = [
  FoodRecentOrder(
    id: '1',
    image: MediaRes.img5,
    name: 'Lemon Pina Colada',
    price: 20,
    height: AppSize.s160,
  ),
  FoodRecentOrder(
    id: '2',
    image: MediaRes.img5,
    name: 'Red Grape Margarita',
    price: 25,
    height: AppSize.s160,
  ),
  FoodRecentOrder(
    id: '3',
    image: MediaRes.img5,
    name: 'Burger King',
    price: 10,
    height: AppSize.s160,
  ),
  FoodRecentOrder(
    id: '4',
    image: MediaRes.img5,
    name: 'Wrap Factory',
    price: 1,
    height: AppSize.s160,
  ),
];

final List<Bill> bills = [
  const Bill(
    date: '2024-01-01',
    id: '1',
    restaurantName: 'Daily Deli',
    total: 25,
  ),
  const Bill(
    date: '2024-01-01',
    id: '1',
    restaurantName: 'Daily Deli',
    total: 25,
  ),
  const Bill(
    date: '2024-01-01',
    id: '1',
    restaurantName: 'Daily Deli',
    total: 25,
  ),
  const Bill(
    date: '2024-01-01',
    id: '1',
    restaurantName: 'Daily Deli',
    total: 25,
  ),
  const Bill(
    date: '2024-01-01',
    id: '1',
    restaurantName: 'Daily Deli',
    total: 25,
  ),
];

// const AccountInfo accountInfo = AccountInfo(
//     name: 'John Doe',
//     email: 'johndoe123@gmail.com',
//     phone: '03014124781',
//     pass: '123456',
//     id: '1');

const Payment paymentInfo = Payment(
    cardName: 'John Doe',
    cardNbr: '1234 1234 1234 4871',
    expiryDate: '02/2023',
    cvc: '123',
    image: MediaRes.card1);

const List<Payment> payments = [
  Payment(
      cardName: 'John Doe',
      cardNbr: '1234 1234 1234 4871',
      expiryDate: '02/2023',
      cvc: '123',
      image: MediaRes.card1),
  Payment(
      cardName: 'John Doe 4',
      cardNbr: '1234 1234 1234 8888',
      expiryDate: '02/2023',
      cvc: '333',
      image: MediaRes.card2),
  Payment(
      cardName: 'John Doe 1',
      cardNbr: '1234 1234 1234 77777',
      expiryDate: '02/2023',
      cvc: '444',
      image: MediaRes.card3)
];

final BillDetail billDetail = BillDetail(
    restaurant: 'Daily Deli',
    date: '23 Jun, 2020',
    orderSummary: orderSummary,
    subTotal: 50,
    vat: 10,
    coupon: 4,
    fee: 4,
    deliveryAddress: 'Block P Phase 1 Johar Town, Lahore',
    deliveryInstruction: 'I am house at around 9 PM',
    paymentInfo: paymentInfo);

final CoordinatesData coordinatesData = CoordinatesData(
    lat: 10.7844036,
    lng: 106.6672684,
    locationName: 'ACB Tower',
    address:
        '444 Đ. Cách Mạng Tháng 8, Phường 11, Quận 3, Thành phố Hồ Chí Minh, Việt Nam');

final List<CoordinatesData> coordinatesDatas = [
  CoordinatesData(
      lat: 10.7844036,
      lng: .6672684,
      locationName: 'ACB Tower',
      address:
          '444 Đ. Cách Mạng Tháng 8, Phường 11, Quận 3, Thành phố Hồ Chí Minh, Việt Nam'),
  CoordinatesData(
      lat: .7497281,
      lng: .6122438,
      locationName: '235 Đ. Vành Đai Trong',
      address:
          '235 Đ. Vành Đai Trong, Bình Trị Đông B, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam'),
  CoordinatesData(
      lat: .7770549,
      lng: 106.6059909,
      locationName: 'Domino\'s Pizza Lê Văn Quới',
      address:
          '480 Đ. Lê Văn Quới, Bình Hưng Hoà A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam'),
];

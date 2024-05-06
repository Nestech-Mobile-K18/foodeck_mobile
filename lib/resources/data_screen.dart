import 'package:template/pages/checkout/model.dart';
import 'package:template/pages/export.dart';
import 'package:template/pages/restaurant/model.dart';

final List<Category> catefories = [
  Category(
    height: 160.dp,
    title: 'Food',
    decription: 'Order food you love',
    img: MediaRes.img1,
    bottom: 16.dp,
  ),
  Category(
    height: 160.dp,
    title: 'Grocery',
    decription: 'Shop daily life items',
    img: MediaRes.img3,
    right: 8.dp,
  ),
  Category(
    height: 160.dp,
    title: 'Deserts',
    decription: 'Something Sweet',
    img: MediaRes.img2,
    left: 8.dp,
  ),
];

const List<String> imgList = [
  MediaRes.sale1,
  MediaRes.sale2,
  MediaRes.sale3,
];

final List<Item> dealsHome = [
  Item(
    id: '1',
    height: 160.dp,
    title: 'Jean’s Cakes',
    address: 'Johar Town',
    img: MediaRes.img4,
    isLike: false,
    isMoney: false,
    rate: 4.0,
    value: '40',
    unit: 'min',
    isTypeTime: true,
  ),
  Item(
    id: '2',
    height: 160.dp,
    title: 'Thicc Shakes',
    address: 'Wapda Town',
    img: MediaRes.img6,
    isLike: false,
    isMoney: false,
    rate: 4.5,
    value: '20',
    unit: 'min',
    isTypeTime: true,
  ),
  Item(
    id: '3',
    height: 160.dp,
    title: 'Daily Deli',
    address: 'Garden Town',
    img: MediaRes.img5,
    isLike: false,
    isMoney: false,
    rate: 4.8,
    value: '30',
    unit: 'min',
    isTypeTime: true,
  ),
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
const FoodType foodType1 = FoodType('1', '8”', 10);
const FoodType foodType2 = FoodType('2', '10”', 12);
const FoodType foodType3 = FoodType('3', '12”', 16);

const FoodExtra foodExtra1 = FoodExtra('1', 'Texas Barbeque', 6);
const FoodExtra foodExtra2 = FoodExtra('2', 'Char Donay', 8);

const FoodInfo foodOrderInfo = FoodInfo(
    [foodType1, foodType2, foodType3],
    1,
    '',
    [foodExtra1, foodExtra2],
    0,
    'Chicken Fajita Pizza',
    'Daily Deli - Johar Town',
    false,
    MediaRes.img1);

final List<FoodStatus> foodOptions = [FoodStatus('Remove it from my order', 0)];

final List<Food> cart = [
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
    quanity: 3,
  ),
  Food(
    id: '51',
    price: 12,
    foodName: 'Chicken Fajita Pizza',
    description: '8” pizza with regular soft drink',
    image: MediaRes.img8,
    quanity: 2,
  ),
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
    quanity: 3,
  ),
];

final List<Item> popularFood = [
  Item(
    id: '1',
    height: 160.dp,
    title: 'Jean’s Cakes',
    address: 'Johar Town',
    img: MediaRes.img4,
    isLike: false,
    isMoney: false,
    rate: 4.0,
    value: '40',
    unit: '\$',
    isTypeTime: false,
  ),
  Item(
    id: '2',
    height: 160.dp,
    title: 'Thicc Shakes',
    address: 'Wapda Town',
    img: MediaRes.img6,
    isLike: false,
    isMoney: false,
    rate: 4.5,
    value: '20',
    unit: '\$',
    isTypeTime: false,
  ),
  Item(
    id: '3',
    height: 160.dp,
    title: 'Daily Deli',
    address: 'Garden Town',
    img: MediaRes.img5,
    isLike: false,
    isMoney: false,
    rate: 4.8,
    value: '30',
    unit: '\$',
    isTypeTime: false,
  ),
];

final List<CardPay> cards = [
  CardPay('370000000000002', 'John Doe', MediaRes.card1),
  CardPay('370000000000003', 'John Doe 1', MediaRes.card2),
  CardPay('370000000000004', 'John Doe 2', MediaRes.card3),
  CardPay('370000000000005', 'John Doe 3', MediaRes.card4),
];


final List<OrderSummary> orderSummary = [
  OrderSummary('Chicken Fajita Pizza',20, 1),
  OrderSummary('Chicken Wrap Deluxe',10, 2),
  OrderSummary('Sandwiches 1',10, 3),
  OrderSummary('Sandwiches 2',8, 1),
 
];



final List<Item> saves = [
  Item(
    id: '1',
    height: 160.dp,
    title: 'Jean’s Cakes',
    address: 'Johar Town',
    img: MediaRes.img4,
    isLike: true,
    isMoney: false,
    rate: 4.0,
    value: '40',
    unit: 'min',
    isTypeTime: true,
  ),
  Item(
    id: '2',
    height: 160.dp,
    title: 'Thicc Shakes',
    address: 'Wapda Town',
    img: MediaRes.img6,
    isLike: true,
    isMoney: false,
    rate: 4.5,
    value: '20',
    unit: 'min',
    isTypeTime: true,
  ),
  Item(
    id: '3',
    height: 160.dp,
    title: 'Daily Deli',
    address: 'Garden Town',
    img: MediaRes.img5,
    isLike: true,
    isMoney: false,
    rate: 4.8,
    value: '30',
    unit: 'min',
    isTypeTime: true,
  ),
];

final List<Notifiacation> notifications=[
  Notifiacation('Your order has arrived', DateTime.parse('2024-01-20 20:18:04Z'),false, ''),
  Notifiacation('Your order is on its way', DateTime.parse('2024-05-06 00:00:04Z'),true, ''),

  Notifiacation('Your order has been placed', DateTime.parse('2024-05-01 20:18:04Z'),true, ''),
  Notifiacation('Your order has arrived', DateTime.parse('2024-01-20 20:18:04Z'),true, ''),
  Notifiacation('Confirm your phone number', DateTime.parse('2024-01-20 20:18:04Z'),true, ''),
  Notifiacation('We have updated our Privacy Policy', DateTime.parse('2024-01-20 20:18:04Z'),true, 'View Privacy Policy'),
  Notifiacation('Your order has been cancelled', DateTime.parse('2024-01-20 20:18:04Z'),true, ''),
  Notifiacation('Your order has arrived', DateTime.parse('2024-01-20 20:18:04Z'),true, ''),
  Notifiacation('Your order has been placed', DateTime.parse('2024-01-20 20:18:04Z'),true, ''),
  Notifiacation('Welcome to Foodeck', DateTime.parse('2024-01-20 20:18:04Z'),true, 'Watch our video'),

];
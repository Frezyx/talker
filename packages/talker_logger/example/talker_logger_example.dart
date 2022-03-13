import 'dart:convert';

import 'package:talker_logger/talker_logger.dart';

void main() {
  final logger = TalkerLogger(
    settings: const TalkerLoggerSettings(
      level: LogLevel.info,
    ),
  );

  logger.log('Test debug');
  logger.log('Test info', level: LogLevel.info);
  logger.log('Test critical', level: LogLevel.critical);
  logger.log('Test error', level: LogLevel.error);
  logger.log('Test fine', level: LogLevel.fine);
  logger.log('Test good', level: LogLevel.good);
  logger.log('Test warning', level: LogLevel.warning);
  logger.log('Test verbose', level: LogLevel.verbose);
  logger.log('Test custom pen log', pen: AnsiPen()..xterm(49));
  logger.log(
    'Test log orem Ipsum is simply dummy text of\nthe printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
  );

  const encoder = JsonEncoder.withIndent('  ');
  final prettyData = encoder.convert(
    {
      "id": "99067fd4-45f1-4fc6-b84e-e4c257e4fff7",
      "route": {
        "from": {
          "id": "ec89e36d-3700-41a7-b35c-509d603359b9",
          "coords": {"latitude": 57.910115, "longitude": 59.993591},
          "name": "Вокзал Нижнего Тагила",
          "cityId": "61d5c6279fc0bf14f33f86dc"
        },
        "to": {
          "id": "ec89e36d-3700-41a7-b35c-509d603359b9",
          "coords": {"latitude": 57.910115, "longitude": 59.993591},
          "name": "Вокзал Нижнего Тагила",
          "cityId": "61d5c6279fc0bf14f33f86dc"
        }
      },
      "package": {
        "id": "2983892c-cdc2-40db-9380-75e9747b596d",
        "photoUrl": "7e2fc61c-24f5-4e6e-913d-51a73926b2bb.jpg",
        "name": "Счётчик",
        "ownerId": "2535080c-c862-4cdc-8270-07b26903076e",
        "weight": {"startWeight": 250, "endWeight": 500}
      },
      "offerCreatorId": "2535080c-c862-4cdc-8270-07b26903076e",
      "creatorIsReceiver": false,
      "status": 9,
      "createdAt": "2022-01-13T21:41:23.046Z",
      "deliveryOffersCount": 1,
      "receiverPhone": "79096633322",
      "senderPhone": "79999999999",
      "deliveryOffers": [
        {
          "id": "d90be81e-67d5-4ba8-ac80-d373523ab820",
          "deliveryman": {
            "id": "90351f4c-90f3-4f4c-bf0c-0a58669842d1",
            "firstName": "Илья",
            "middleName": "Ермолаев",
            "lastName": "Дмитриевич",
            "phone": "71111111111",
            "email": "Ermolaev.ID@yandex.ru",
            "avatarUrl": null,
            "verified": true,
            "createdAt": "2021-11-24T12:26:30.381Z",
            "packages": [
              "83701019-1766-4d7f-a58a-be836f8e56a8",
              "59387505-595f-4af6-adb4-6bd16b703d02",
              "e9de65fb-80e0-46df-8736-6d4dfbc2e4d9",
              "0cd6e7cf-2d95-45bc-8f75-ccc4d435c85f",
              "70f0e1f4-dcb2-4e10-ba26-d7e62633c756",
              "76120603-01bc-47a9-a0ec-0d5d393c46d6",
              "b6ee5bcf-fa61-4ef4-87d1-8530511e1756",
              "cb394d8a-caf9-4cb7-935b-7b2f21052609",
              "75e21714-2275-4b07-9f19-6f666fa55be4",
              "d303aa76-2c60-407d-a5ab-641e1e069d49",
              "e42386d1-16c4-47d2-ab42-5ac7276abe88",
              "64cd5370-3722-4bb3-8e7f-6bac2e8ec852",
              "3b58d5df-118c-46ad-b6ca-7fd92eb81558",
              "6f2c7261-e7f9-432e-8cb8-8fbfc0e2a613",
              "f0f11d3e-8856-4157-b3f9-d0a0fd05328d"
            ],
            "offers": [
              "09919b41-cdf1-450e-be8c-4d34dbb93c36",
              "98763e30-2e53-42ff-9e47-43cdcf9f8a12",
              "ead71851-5129-44fd-9cc2-8e91cef0a650",
              "f137509c-3417-4e46-9339-7700edc37573",
              "a2456d73-112e-4707-8e3b-eb8a0a228465",
              "a530380c-b99d-4162-9a32-bc47bc1ede7f",
              "6e3f15a3-d3d9-45e7-b21e-3e6a887e7e3e",
              "88e18a0e-3315-422c-a7d5-a0c504d6e182",
              "a5e1ad7a-7628-425e-a193-eae9edc1125e",
              "8ecbe7d6-1d4b-4bea-a93b-15e16e1d8db3",
              "3700efc1-a209-47a0-af29-5964a91ebc8a",
              "124a9ceb-6e3e-49e5-aa07-f966679c3716",
              "29c2b0c3-f4e4-4a16-87b9-b7ead5f3fb7d",
              "f14c46e0-a7ff-4c83-a014-3dfd0e77e4a3"
            ],
            "deliveryOffersIds": [
              "d90be81e-67d5-4ba8-ac80-d373523ab820",
              "b1c74eff-eb19-4037-b2e7-05f56e437a11",
              "998461c0-133f-4749-bee3-a66a7f11a843",
              "0ffba6d9-ace3-43b6-912c-4d133e9fbdb6",
              "a8e850f1-1f13-4795-84df-178c924ab2f4",
              "21ffc3ff-2fe9-4f3a-89d6-3514acda3736",
              "a04d0aec-5529-4319-8e29-663cc51a0752",
              "e43b2f7d-6770-448e-a59f-3988fd58b9a2",
              "fcc0b3f4-1364-4d8b-8633-466432a044bd"
            ],
            "deliveredOffersCount": null,
            "privacyConfig": null
          },
          "deliverymanId": "90351f4c-90f3-4f4c-bf0c-0a58669842d1",
          "consumerOfferId": "99067fd4-45f1-4fc6-b84e-e4c257e4fff7",
          "status": 3,
          "payment": {"value": 100, "currency": "RUB", "status": 2},
          "timeTerms": {
            "shipmentStartTime": "2022-02-04T18:20:00.000Z",
            "dischargeStartTime": "2022-02-04T20:15:00.000Z"
          }
        }
      ],
      "selectedDeliveryOfferId": "d90be81e-67d5-4ba8-ac80-d373523ab820",
      "offerCreator": {
        "id": "2535080c-c862-4cdc-8270-07b26903076e",
        "firstName": "Станислав",
        "middleName": "Павлович",
        "lastName": "Ильин",
        "avatarUrl": "cd425d34-90b9-45b6-9335-3679a0f3a867.jpg",
        "offersIds": [
          "63870d35-48c8-4803-ad52-3d89ee39a12e",
          "f064fa90-56e2-42a9-a560-9638c4273e8f",
          "5464e579-7144-4e2d-b82b-7050e91d596c",
          "0eb82530-968e-422b-b34f-07579b9bc181",
          "f061fb6f-e744-41ae-88ee-5ff74f608a03",
          "e1d2afcd-02d2-465e-bdf7-be0955e56c29",
          "a8259b17-89d1-4b3f-997d-e308d76e1a32",
          "99067fd4-45f1-4fc6-b84e-e4c257e4fff7",
          "68019b7b-316c-49c9-a092-f0eee51a9a7c",
          "c15e56ab-0414-4d11-8fc6-391ef2093828",
          "c03cebcd-c00b-443e-b2d4-fe6b78387835",
          "aa1e3f52-4b3c-47f3-a9c7-78c5a6dd675a",
          "45acfaab-9ba8-4188-862e-bea4660d21e6",
          "ecbd8a8e-ca30-4a9f-84b8-d7a086e5dbc6",
          "be82d051-620f-45e3-a135-5eb9f1bc4e78",
          "cd409ec9-1de5-4af6-998d-80808daf50e1"
        ],
        "phone": "79999999999"
      }
    },
  );
  logger.log(prettyData);
}

import 'dart:convert';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:fluuter_interm_restaurant_app/data/rest/api_services.dart';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_list.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'Testing Restaurant Api',
        () {
      test('When http call complete success return list of restaurant', () async {
        final client = MockClient((request) async {
          final response = {
            "error": false,
            "message": "success",
            "count": 20,
            "restaurants": []
          };
          return Response(json.encode(response), 200);
        });
        expect(
          await ApiService(client).getRestaurantList(),
          isA<RestaurantListResult>(),
        );
      });

      test('Test verify json response detail restaurant by sample id', () async {
        const String id = 'rqdv5juczeskfw1e867';
        final client = MockClient((request) async {
          final response = {

            "error": false,
            "message": "success",
            "restaurant": {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
              "city": "Medan",
              "address": "Jln. Pandeglang no 19",
              "pictureId": "14",
              "categories": [
                {
                  "name": "Italia"
                },
                {
                  "name": "Modern"
                }
              ],
              "menus": {
                "foods": [
                  {
                    "name": "Paket rosemary"
                  },
                  {
                    "name": "Toastie salmon"
                  }
                ],
                "drinks": [
                  {
                    "name": "Es krim"
                  },
                  {
                    "name": "Sirup"
                  }
                ]
              },
              "rating": 4.2,
              "customerReviews": [
                {
                  "name": "Ahmad",
                  "review": "Tidak rekomendasi untuk pelajar!",
                  "date": "13 November 2019"
                }
              ]
            }
          };
          return Response(json.encode(response), 200);
        });
        expect(await ApiService(client).getRestaurantDetail(id), isA<RestaurantDetailResult>());
      });
    },
  );
}
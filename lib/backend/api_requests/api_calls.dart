import 'dart:convert';
import 'dart:typed_data';

import '/ff/ff_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start register Group Code

class RegisterGroup {
  static String baseUrl = 'https://staging.rifamas.es/wp-json';
  static Map<String, String> headers = {};
}

/// End register Group Code

/// Start create membresy Group Code

class CreateMembresyGroup {
  static String baseUrl = 'https://staging.rifamas.es/wp-json/';
  static Map<String, String> headers = {};
  static CreateCall createCall = CreateCall();
}

class CreateCall {
  Future<ApiCallResponse> call({
    String? variacion1 = '',
    String? variacion2 = '',
    String? variacion3 = '',
    String? papeletasvariacion1 = '',
    String? papeletasvariacion2 = '',
    String? papeletasvariacion3 = '',
    String? opcionessorteos = '',
    String? logo = '',
    String? descripcion = '',
    String? nombreproducto = '',
    String? author = '',
    String? optionSorteos = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'create',
      apiUrl: '${CreateMembresyGroup.baseUrl}membresia/v1/crear',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'variacion-2': variacion2,
        'variacion-3': variacion3,
        'papeletas-variacion-1': papeletasvariacion1,
        'papeletas-variacion-2': papeletasvariacion2,
        'papeletas-variacion-3': papeletasvariacion3,
        'descripcion': descripcion,
        'nombre-producto': nombreproducto,
        'logo_url': logo,
        'variacion-1': variacion1,
        'author': author,
        '_option_sorteos': optionSorteos,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End create membresy Group Code

/// Start wallet Group Code

class WalletGroup {
  static String baseUrl = 'https://staging.rifamas.es/wp-json/wc/v2/wallet';
  static Map<String, String> headers = {};
  static GetBalanceCall getBalanceCall = GetBalanceCall();
}

class GetBalanceCall {
  Future<ApiCallResponse> call({
    String? idUser = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'get balance',
      apiUrl: '${WalletGroup.baseUrl}/balance/${idUser}',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'consumer_key': "ck_aa336b291d7f28b57c830ae5472a06d4d8e6a1ee",
        'consumer_secret': "cs_728cb39cc32c4d5d26c01977b84cba580bca36c9",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End wallet Group Code

class GetProductsCall {
  static Future<ApiCallResponse> call({
    String? search = '',
    int? perPage = 10,
    int? page = 1,
    int? author,
    String? type = '',
    String? category = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'get products',
      apiUrl: 'https://staging.rifamas.es/wp-json/wc/v3/products',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'consumer_key': "ck_aa336b291d7f28b57c830ae5472a06d4d8e6a1ee",
        'consumer_secret': "cs_728cb39cc32c4d5d26c01977b84cba580bca36c9",
        'search': search,
        'per_page': perPage,
        'page': page,
        'author': author,
        'type': type,
        'category': category,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic productName(dynamic response) => getJsonField(
        response,
        r'''$[:].name''',
        true,
      );
  static dynamic productImage(dynamic response) => getJsonField(
        response,
        r'''$[:].images[0].src''',
        true,
      );
}

class GetHomeProductsCall {
  static Future<ApiCallResponse> call({
    String? search = '',
    int? perPage = 10,
    int? page = 1,
    int? author,
    String? category = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'get Home Products',
      apiUrl: 'https://staging.rifamas.es/wp-json/wc/v3/products',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'consumer_key': "ck_aa336b291d7f28b57c830ae5472a06d4d8e6a1ee",
        'consumer_secret': "cs_728cb39cc32c4d5d26c01977b84cba580bca36c9",
        'search': search,
        'per_page': perPage,
        'page': page,
        'category': category,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic productName(dynamic response) => getJsonField(
        response,
        r'''$[:].name''',
        true,
      );
  static dynamic productImage(dynamic response) => getJsonField(
        response,
        r'''$[:].images[0].src''',
        true,
      );
}

class GetSingleProductCall {
  static Future<ApiCallResponse> call({
    int? idProduct,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'get single product',
      apiUrl: 'https://staging.rifamas.es/wp-json/wc/v3/products/${idProduct}/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'consumer_key': "ck_aa336b291d7f28b57c830ae5472a06d4d8e6a1ee",
        'consumer_secret': "cs_728cb39cc32c4d5d26c01977b84cba580bca36c9",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class LoginCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    return await ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: 'https://staging.rifamas.es/wp-json/api/v1/user_data',
      // apiUrl: 'https://staging.rifamas.es/wp-json/jwt-auth/v1/token',
      callType: ApiCallType.POST,
      headers: {
        'username': username,
        'password': password,
      },
      params: {
        'username': username,
        'password': password,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic token(dynamic response) => getJsonField(
        response,
        r'''$.jwt_token''',
      );
}

class TicketsComprados {
  static Future<ApiCallResponse> call({
    String? user_id = '',
    String? product_id = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: 'https://staging.rifamas.es/wp-json/rifamas/v1/papeletas_usuario',
      //apiUrl: 'https://staging.rifamas.es/wp-json/jwt-auth/v1/token',
      callType: ApiCallType.GET,
      headers: {
        'user_id': user_id,
        'product_id': product_id,
      },
      params: {
        'user_id': user_id,
        'product_id': product_id,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic token(dynamic response) => getJsonField(
        response,
        r'''$.jwt_token''',
      );
}

class RegisterCall {
  static Future<ApiCallResponse> call({
    String? username = 'brupadiro',
    String? name = 'test',
    String? firstName = 'Bruno',
    String? lastName = 'Diharce',
    String? email = 'brupadiro@hotmail.com',
    String? password = '983f07553',
    String? roles = 'customer',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'register',
      // apiUrl: 'https://staging.rifamas.es/wp-json/wc/v2/users/',
      apiUrl: 'https://staging.rifamas.es/wp-json/wc/v3/customers/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Basic Y2tfYWEzMzZiMjkxZDdmMjhiNTdjODMwYWU1NDcyYTA2ZDRkOGU2YTFlZTpjc183MjhjYjM5Y2MzMmM0ZDVkMjZjMDE5NzdiODRjYmE1ODBiY2EzNmM5'
      },
      params: {
        'username': username,
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'roles': roles,
        'consumer_key': "ck_aa336b291d7f28b57c830ae5472a06d4d8e6a1ee",
        'consumer_secret': "cs_728cb39cc32c4d5d26c01977b84cba580bca36c9",
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class CreateProductCall {
  static Future<ApiCallResponse> call({
    String? rifaType = '',
    String? name = '',
    String? category = '',
    String? productState = '',
    String? rifaType2 = '',
    String? price = '',
    String? pesoProducto = '',
    String? maxTickets = '',
    String? lotteryPrice = '',
    String? description = '',
    String? shortDescription = '',
    String? type = '',
    List<FFUploadedFile>? imagesList,
    int? author,
  }) async {
    final images = imagesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'create product',
      apiUrl: 'https://staging.rifamas.es/wp-json/rifamas/v1/crear-producto',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'name': name,
        'description': description,
        'short_description': shortDescription,
        'type': type,
        '_tipo_rifa_1': rifaType,
        '_tipo_rifa_2': rifaType2,
        'precio': price,
        'images': images,
        '_max_tickets': maxTickets,
        '_lottery_price': lotteryPrice,
        'author': author,
        'peso_producto': pesoProducto,
        '_weight_product': pesoProducto,
        '_product_state': productState,
        'category': category,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class CategoriesCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'categories',
      apiUrl: 'https://staging.rifamas.es/wp-json/wc/v3/products/categories/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'consumer_key': "ck_aa336b291d7f28b57c830ae5472a06d4d8e6a1ee",
        'consumer_secret': "cs_728cb39cc32c4d5d26c01977b84cba580bca36c9",
        'per_page': 20,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic name(dynamic response) => getJsonField(
        response,
        r'''$[:].name''',
        true,
      );
  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$[:].id''',
        true,
      );
}

class UploadMediaCall {
  static Future<ApiCallResponse> call({
    String? mediaAttachment = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'upload media',
      apiUrl: 'https://staging.rifamas.es/wp-json/wp/v2/media/',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'media_attachment': mediaAttachment,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class CreateMembresyCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'create membresy',
      apiUrl:
          'https://staging.rifamas.es/wp-json/wc/v3/products/?consumer_key=ck_aa336b291d7f28b57c830ae5472a06d4d8e6a1ee&consumer_secret=cs_728cb39cc32c4d5d26c01977b84cba580bca36c9',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class CreateGiftCall {
  static Future<ApiCallResponse> call({
    FFUploadedFile? imagen,
    String? date = '',
    String? description = '',
    String? productID = '',
    String? name = '',
    String? author = '',
    String? type = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'create gift',
      apiUrl: 'https://staging.rifamas.es/wp-json/rifamas/v1/crear-regalo',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'imagen': imagen,
        'description': description,
        'product_ID': productID,
        'name': name,
        'date': date,
        'author': author,
        'type': type,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetSubscriptionsCall {
  static Future<ApiCallResponse> call({
    String? author,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'get subscriptions',
      apiUrl:
          'https://staging.rifamas.es/wp-json/rifamas/v1/variable-subscription',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        if (author != null) 'author': author,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class UploadImageCall {
  static Future<ApiCallResponse> call({
    FFUploadedFile? file,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'upload image',
      apiUrl: 'https://staging.rifamas.es/wp-json/rifamas/v1/upload-image',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'file': file,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetRelatedProductsCall {
  static Future<ApiCallResponse> call({
    String? idMembershipData = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'get related products',
      apiUrl: 'https://staging.rifamas.es/wp-json/rifamas/v1/products/meta',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'id_membership_data': idMembershipData,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class BuyLotteryCall {
  static Future<ApiCallResponse> call({
    String? lotteryNumber = '',
    String? productId = '',
    String? userId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "payment_method": "bacs",
  "payment_method_title": "Direct Bank Transfer",
  "set_paid": true,
  "customer_id": "${userId}",
  "line_items": [
    {
      "product_id": "${productId}",
      "quantity": 1,
      "meta_data": [
        {
          "key": "Número de papeleta ",
          "value": "${lotteryNumber}",
          "display_key": "Número de papeleta",
          "display_value": "${lotteryNumber}"
        }
      ]
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'buy lottery',
      apiUrl: 'https://staging.rifamas.es/wp-json/wc/v3/orders/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class FavoritesCall {
  static Future<ApiCallResponse> call({
    List<int>? favoritesList,
  }) async {
    final favorites = _serializeList(favoritesList);

    return ApiManager.instance.makeApiCall(
      callName: 'favorites',
      apiUrl: 'https://staging.rifamas.es/wp-json/rifamas/products/favorites/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'ids': favorites,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class viewProduct {
  static Future<ApiCallResponse> call({
    int? productId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'mark as favorite',
      apiUrl: 'https://staging.rifamas.es/wp-json/rifamas/v1/send_product_view',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'product_id': productId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class markAsFavorite {
  static Future<ApiCallResponse> call({
    int? productId,
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'mark as favorite',
      apiUrl: 'https://staging.rifamas.es/wp-json/wp/v3/add_favorite_product',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'product_id': productId,
        'user_id': userId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class AddToCartCall {
  static Future<ApiCallResponse> call({
    int? userId,
    int? productId,
    int? variationId = 0,
    List<int>? ticketsList,
    int? price,
  }) async {
    final tickets = _serializeList(ticketsList);

    return ApiManager.instance.makeApiCall(
      callName: 'add to cart',
      apiUrl: 'https://staging.rifamas.es/wp-json/wp/v2/add_to_cart_product',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'user_id': userId,
        'product_id': productId,
        'variation_id': variationId,
        'tickets': tickets,
        'price': price,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ComprobarMembresiaCall {
  static Future<ApiCallResponse> call({
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'comprobar membresia',
      apiUrl:
          'https://staging.rifamas.es/wp-json/membresia/v1/comprobar_membresia',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class MyOrderedProductsCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? type = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'my ordered products',
      apiUrl: 'https://staging.rifamas.es/wp-json/rifamas/v1/productos_usuario',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'id': userId,
        'product_type': type,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class SelledProductsCall {
  static Future<ApiCallResponse> call({
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'selled products',
      apiUrl:
          'https://staging.rifamas.es/wp-json/rifamas/v1/productos_vendidos/${userId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ny_times_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NyTimesResponse _$NyTimesResponseFromJson(Map<String, dynamic> json) {
  return NyTimesResponse(
    copyright: json['copyright'] as String,
    numResults: json['num_results'] as int,
    articles: (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : ArticleResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NyTimesResponseToJson(NyTimesResponse instance) =>
    <String, dynamic>{
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'results': instance.articles,
    };

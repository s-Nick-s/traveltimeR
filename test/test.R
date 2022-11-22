
library(httr)
library(RProtoBuf)

Sys.setenv(TRAVELTIME_ID = "")
Sys.setenv(TRAVELTIME_KEY = "")

get_api_headers_test <- function(format = NULL, contentType = NULL) {

  id <- Sys.getenv('TRAVELTIME_ID')
  key <- Sys.getenv('TRAVELTIME_KEY')

  if (identical(id, "")) {
    stop("Please set env var TRAVELTIME_ID to your Travel Time Application Id",
         call. = FALSE)
  }
  if (identical(key, "")) {
    stop("Please set env var TRAVELTIME_KEY to your Travel Time Api Key",
         call. = FALSE)
  }

  httr::add_headers(`X-Application-Id` = id, `X-Api-Key` = key,
                    `Accept` = format, `Content-Type` = contentType)
}

RProtoBuf::readProtoFiles(dir = "./test")
message <- RProtoBuf::new(com.igeolise.traveltime.rabbitmq.requests.TimeFilterFastRequest,
                          oneToManyRequest = NULL)

ctype = "application/octet-stream"
uri <- httr::modify_url("http://proto.api.traveltimeapp.com",
                        path = c('api', "v2", "uk", "time-filter", "fast", "pt"))
resp <- httr::POST(url = uri, get_api_headers_test(format = ctype, contentType = ctype),
                   body = message$serialize(NULL),
                   httr::authenticate(Sys.getenv('TRAVELTIME_ID'), Sys.getenv('TRAVELTIME_KEY')), encode = 'raw')

respMsg <- com.igeolise.traveltime.rabbitmq.responses.TimeFilterFastResponse$read(resp$content)
respMsg$as.character() |> print()




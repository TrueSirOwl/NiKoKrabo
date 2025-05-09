#include "../resources/dmbcs/dmbcs-kraken-api.h"
#include "../resources/simdjson/simdjson.h"
#include <iostream>
#include <string>

int main(int argc, char **argv){

	simdjson::padded_string jsonString;
	simdjson::ondemand::parser parser;

	std::cout << "hello world" << std::endl;
	auto  K  =  DMBCS::Kraken_API  {"<your-key>", "<your-secret>"};

	// pad the result of ticker_info for processing with simdjson
	jsonString = simdjson::padded_string(K.ticker_info ("XXBTZUSD"));

	std::cout << jsonString << "\n----------------------" << std::endl;

	// create a document that the parser loads the string into
	simdjson::ondemand::document doc = parser.iterate(jsonString);

	// extract the first object from the json
	simdjson::ondemand::object body = doc.get_object();

	// create a iterator over all subobjects of the body
	auto it = body.begin();

	// get the field (value) of the first subobject
	auto val = *it.value();

	// output the key and content of the first subobject
	std::cout << "key: " << val.key() << ", value: " << val.value() << std::endl;

	++it;
	val = *it.value();
	std::cout << "key: " << val.key() << ", value: " << val.value() << std::endl;


	return 0;
}
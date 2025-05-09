#include <iostream>
#include "../resources/dmbcs/dmbcs-kraken-api.h"

int main(int argc, char **argv){
    std::cout << "hello world" << std::endl;
    auto  K  =  DMBCS::Kraken_API  {"<your-key>", "<your-secret>"};
    std::cout << K.ticker_info ("XXBTZUSD");
    return 0;
}
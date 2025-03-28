#include <gtest/gtest.h>
#include "../src/example.cpp"

TEST(addOne, functions){
    EXPECT_EQ(addOne(2), 3);
}

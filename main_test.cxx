#include <gtest/gtest.h>
#include <iostream>

#include "main.hpp"

using namespace unum;

TEST(CppTemplateTest, Add) {
    ASSERT_EQ(2, add(1, 1));
    ASSERT_EQ(5, add(3, 2));
    ASSERT_EQ(10, add(7, 3));
}

TEST(CppTemplateTest, Sub) {
    ASSERT_EQ(3, sub(5, 2));
    ASSERT_EQ(-10, sub(5, 15));
}

int main(int argc, char **argv) {
    std::cout << "Welcome to Unum!\n";
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
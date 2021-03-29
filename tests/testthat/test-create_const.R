test_that("constant can be assigned",{

  expect_equal(x := 2,2)

})

test_that("constant assignment invisibly returns", {

  expect_invisible(x:=2)

})

test_that("constant cannot be assigned again",{

  x := 3
  expect_error(x := 2)

})

test_that("constant is correct value",{

  x := 3
  expect_s3_class(x,"const")
  expect_s3_class(x,class(3))
  expect_equal(unclass(x),3)

})


test_that("constant can be removed",{

  expect_invisible(x := 2)
  expect_equal(unclass(x),2)
  expect_null(rm(x))
  expect_invisible(x := 3)

})

test_that("ops on const strips const",{

  x := 2
  y := 3

  z := TRUE

  expect_false(inherits(x + y,"const"))
  expect_false(inherits(-x,"const"))
  expect_false(inherits(!z,"const"))

})

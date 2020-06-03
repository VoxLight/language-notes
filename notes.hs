{-
      ___           ___           ___           ___           ___           ___       ___ 
     /\__\         /\  \         /\  \         /\__\         /\  \         /\__\     /\__\
    /:/  /        /::\  \       /::\  \       /:/  /        /::\  \       /:/  /    /:/  /
   /:/__/        /:/\:\  \     /:/\ \  \     /:/__/        /:/\:\  \     /:/  /    /:/  / 
  /::\  \ ___   /::\~\:\  \   _\:\~\ \  \   /::\__\____   /::\~\:\  \   /:/  /    /:/  /  
 /:/\:\  /\__\ /:/\:\ \:\__\ /\ \:\ \ \__\ /:/\:::::\__\ /:/\:\ \:\__\ /:/__/    /:/__/   
 \/__\:\/:/  / \/__\:\/:/  / \:\ \:\ \/__/ \/_|:|~~|~    \:\~\:\ \/__/ \:\  \    \:\  \   
      \::/  /       \::/  /   \:\ \:\__\      |:|  |      \:\ \:\__\    \:\  \    \:\  \  
      /:/  /        /:/  /     \:\/:/  /      |:|  |       \:\ \/__/     \:\  \    \:\  \ 
     /:/  /        /:/  /       \::/  /       |:|  |        \:\__\        \:\__\    \:\__\
     \/__/         \/__/         \/__/         \|__|         \/__/         \/__/     \/__/
-}

-- This is a single-line comment.


-- Before we really get started, I feel as if it's important to make note that
-- everything is a function, including operators. Reminiscent of Lisps, and...
-- little else. Binary operators like those used for math are "infix" functions,
-- meaning that their arguments can be found on each side of the operator. Most
-- function calls will be of the "prefix" form, however.


-- Basic math is essentially the same as everywhere else:
6 + 3         --   9
12 - 14       --  -2
20 * 12       -- 240
10 / 4        --   2.5
2 ** 8        -- 256.0   (Exponentiation returns a float)
5 + 10 * 2    --  25
(5 + 10) * 2  --  30

-- However, due to some of Haskell's weirdness, negation isn't so simple.
5 * -2    -- This causes an error! Instead, one must do this:
5 * (-2)  -- -10

-- Boolean operators are shared with JavaScript.
True && False  -- False
True || False  -- True
-- ...except for boolean negation, which is like Python's. ok.
not True  -- False

-- Comparisons are mostly normal, aside from the syntax of not-equals.
5 == 5  -- True
5 /= 4  -- True
5 > 4   -- True
5 < 6   -- True
5 >= 2  -- True
5 <= 8  -- True


-- -- Functions! -- --

-- Function calls consume the function arguments first, before anything else is
-- done. If an argument needs some calculation to be done, you'll have to use
-- parentheses to group the operation into a single value.
min 9 10       -- Returns the lesser of its two arguments.
max 5 4        -- Returns the greater of its two arguments.
max 4 2 + 1    -- Essentially (max 4 2) + 1, i.e. 5
min 4 (2 + 1)  -- 3

-- Two-arg prefix functions can be surrounded by backticks to make them infix:
12 `div` 6  -- 2

-- Defining a function is pretty simple.
timesTwo x = x * 2
timesTwo 12  -- 24
addTimesTwo x y = timesTwo (x + y)
addTimesTwo 10 5  -- 30
-- Function names can't begin with a capital letter, but they can contain '


-- -- Flow control! -- --

-- ifs are easy.
if 5 > 4 then 6 else 3  -- 6
-- Some extra whitespace is ok too.
if 5 < 4
    then 6
    else 3  -- 3


-- -- Lists! -- --

-- All normal lists using square brackets [] are homogenous, containing values
-- of only a single type. Lists are, vitally, immutable.
[1, 2, 3, 4, 5]
-- This operator (called the "cons" operator) adds items to the front of a list.
1 : 2 : [3, 4, 5]  -- [1, 2, 3, 4, 5]
-- String literals are just syntactic sugar for lists of chars.
"hello" == ['h', 'e', 'l', 'l', 'o']  -- True
-- Two lists (including strings, of course) can be combined with ++
"hello " ++ "world"  -- "hello world"
-- The !! operator can be used to index into lists.
exList !! 1  -- 4
-- Lists can be compared if their contents can be, starting with the first
-- element. If one is greater, that list is greater. If they're equivalent, it
-- moves on to the second element, and so on.
[1, 1, 1] > [2, 2, 2]  -- False
[2, 1, 1] > [1, 5, 5]  -- True

-- 2D (or greater) lists must have consistently-typed lists as values, just as
-- the immediate contents of a list must be of the same type. For example:
[[1, 2, 3], ['a', 'b', 'c']]  -- NOT VALID

-- Now for some simple list functions.
let exList = [2, 4, 6, 8, 10]
head exList     -- 2
tail exList     -- [4, 6, 8, 10]
last exList     -- 10
init exList     -- [2, 4, 6, 8]
length exList   -- 5
null exList     -- False  (determines whether a list is empty)
reverse exList  -- [10, 8, 6, 4, 2]

-- Aaand some more complex ones:
take 3 exList   -- [2, 4, 6]  (first n elements in l, or l if n >= length l)
drop 3 exList   -- [6, 8, 10]  (essentially the opposite of take)
maximum exList  -- 10  (greatest element in a list of _comparable_ values)
minimum exList  -- 2
sum exList      -- 30
elem 6 exList   -- True  (whether the first argument is found in the second)

-- Lists also get some cool little range shortcuts.
[1..10]  -- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
['a'..'f']  -- "abcdef"
-- They can also be defined with a step, shortening that exList to:
[2,4..10]  -- In English: first value, second value, then ..last value.
-- That is the only way to get reverse lists with this feature.
[10,9..1]
-- Haskell's lazy value calculation allows you to do interesting things like
-- get only the first n values of what would otherwise be an infinite range.
take 5 [10,20..]  -- [10, 20, 30, 40, 50]
-- There are infinite-list-generating functions that you can use that fact with.
take 7 (cycle "uw")  -- "uwuwuwu"
take 3 (repeat 7)  -- [7, 7, 7]
-- replicate serves a similar purpose as repeat, with simpler usage
replicate 3 7  -- [7, 7, 7]

-- List comprehensions are simple enough, if you ignore the strange separators.
[x*2 | x <- [1..10]]  -- [2, 4, 6, 8..20]  (equivalent to (x*2 for x in range(10)) in Python)

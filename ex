  /**
   * Problem 1:
   * If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
   * Find the sum of all the multiples of 3 or 5 below 1000.
   */
  def problem1(range: Int, position: Int = 0, currentSum: Int = 0): Int = {
    if (position < range)
      problem1(range, position + 1, if (position % 3 == 0 || position % 5 == 0) currentSum + position else currentSum)
    else currentSum
  }

  /**
   * Problem 2:
   * Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
   * 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
   * By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
   */
  def problem2(maxValue: Int = 4000000, firstPrevTerm: Int = 1, secondPrevTerm: Int = 2, currentSum: Int = 2): Int = {
    val nextTerm = firstPrevTerm + secondPrevTerm
    if (nextTerm >= maxValue) currentSum
    else problem2(maxValue, secondPrevTerm, nextTerm, if (nextTerm % 2 == 0) currentSum + nextTerm else currentSum)
  }

  /**
   * Problem 3
   * The prime factors of 13195 are 5, 7, 13 and 29.
   * What is the largest prime factor of the number 600851475143 ?
   */
  def problem3(term: Long, currentFactor: (Long, Long), currentMaxPrime: Long = 1): Long = {

    /**
     * Accessory Functions
     */

    def isPrime(num: Long, pos: Long = 2): Boolean = {
      if (pos >= scala.math.sqrt(num) + 1) true
      else if (num % pos == 0) false
      else isPrime(num, pos + 1)
    }

    def getNextFactor(position: Long = currentFactor._1 + 1): (Long, Long) = {
      if (term % position > 0) getNextFactor(position + 1)
      else (position, term / position)
    }

    if (!isPrime(currentFactor._2)) problem3(term, getNextFactor())
    else currentFactor._2
  }

  /**
   * Problem 4
   * Find the largest palindrome made from the product of two 3-digit numbers. (Largest two digit is 9009 = 91 * 99)
   */
  def problem4(currentDigits: (Int, Int) = (999, 999), currentLargestPal: Int = 0): Int = {

    /**
     * Accessory Functions
     */
    def isPalindrome(digit: Int): Boolean = {
      val strDigit = digit.toString
      strDigit == strDigit.reverse
    }

    def getNextDigits: (Int, Int) = {
      val (left, right) = currentDigits
      if (right == 99) (left - 1, 999) //TODO: Fix this to match 3 digits
      else (left, right - 1)
    }

    val digi = currentDigits._1 * currentDigits._2
    val newLargestPal = if (isPalindrome(digi) && digi >= currentLargestPal) digi else currentLargestPal
    if (currentDigits._1 > 99) problem4(getNextDigits, newLargestPal)
    else currentLargestPal
  }

  /**
   * Problem 5
   * What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
   */
  def problem5(num: Int = 20): Int = {

    /**
     * Accessory Functions
     */
    def isEvenlyDivisible(curPosition: Int = 2): Boolean = {
      if (num % curPosition > 0) false
      else if (curPosition >= 20) true
      else isEvenlyDivisible(curPosition + 1)
    }

    if (isEvenlyDivisible()) num
    else problem5(num + 1)

  }

  /**
   * Problem 6
   * Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum. (first 10 is 2640)
   */

  def problem6(num: Int): Long = {
    (Math.pow((1 to num).sum, 2) - (1 to num).map(Math.pow(_, 2)).sum).toLong
  }

  /**
   * Problem 7
   * What is the 10 001st prime number?
   */

  def isPrime(num: Long, pos: Long = 2): Boolean = {
    if (pos >= scala.math.sqrt(num) + 1) true
    else if (num % pos == 0) false
    else isPrime(num, pos + 1)
  }

  def problem7(curPos: Long = 1, primeCount: Long = 0): Long = {

    /**
     * Accessory Functions
     */

    val count = primeCount + (if (isPrime(curPos)) 1 else 0)

    if (count == 10001) curPos
    else problem7(curPos + 1, count)

  }

  /**
   * Problem 8
   * Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?
   */
  def problem8(numAdjacentDigits: Int, headPos: Int = 0, curGreatestProduct: Long = 0): Long = {
    val newProduct = models.Euler.problem8Data.slice(headPos, headPos + numAdjacentDigits).product
    val newGreatestProduct = if (curGreatestProduct > newProduct) curGreatestProduct else newProduct
    if (curGreatestProduct < newGreatestProduct) println(newGreatestProduct, headPos)
    if (headPos + numAdjacentDigits >= models.Euler.problem8Data.length) newGreatestProduct
    else problem8(numAdjacentDigits, headPos + 1, newGreatestProduct)
  }

  /**
   * Problem 8
   * Find the product of a*b*c where they are a Pythagorean Triplet and a+b+c=1000
   */
  def problem9(a: Double = 1, b: Double = 2): Long = {

    val c = math.sqrt(math.pow(a, 2) + math.pow(b, 2))
    /**
     * Accessory Functions
     */
    def calcNextSet: (Double, Double) = {
      if (a + b + c >= 1000) (a + 1, a + 2)
      else (a, b + 1)
    }

    if (c % 1 == 0 && b < c && a + b + c == 1000) {
      a.toLong * b.toLong * c.toLong
    } else {
      val (_a, _b) = calcNextSet
      problem9(_a, _b)
    }
  }

  /**
   * Problem 10
   * Find the sum of all the primes below two million.
   */
  def problem10(currentNum: Long = 2, currentSum: Long = 2): Long = {
    if (currentNum >= 2000000) currentSum
    else
      problem10(currentNum + 1, if (isPrime(currentNum)) currentSum + currentNum else currentSum)
  }

  /**
   * Problem 11
   * What is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20×20 grid?
   */

  type Position = (Int, Int)

  def problem11(curPos: Position = (0, 0), curGreatestProduct: Long = 0.toLong): Long = {

    /**
     * Accessory Functions
     */
    val nextPosition: Position = {
      if (curPos._2 >= 19) (curPos._1 + 1, 0)
      else (curPos._1, curPos._2 + 1)
    }

    def getValue(pos: Position): Long = {
      if (pos._1 < 0 || pos._1 >= 20 || pos._2 < 0 || pos._2 >= 20) 0
      else models.Euler.problem11Data(pos._1)(pos._2)
    }

    val up = getValue(curPos) * getValue((curPos._1 - 1, curPos._2)) * getValue((curPos._1 - 2, curPos._2)) * getValue((curPos._1 - 3, curPos._2))

    val down = getValue(curPos) * getValue((curPos._1 + 1, curPos._2)) * getValue((curPos._1 + 2, curPos._2)) * getValue((curPos._1 + 3, curPos._2))

    val left = getValue(curPos) * getValue((curPos._1, curPos._2 - 1)) * getValue((curPos._1, curPos._2 - 2)) * getValue((curPos._1, curPos._2 - 3))

    val right = getValue(curPos) * getValue((curPos._1, curPos._2 + 1)) * getValue((curPos._1, curPos._2 + 2)) * getValue((curPos._1, curPos._2 + 3))

    val upLeft = getValue(curPos) * getValue((curPos._1 - 1, curPos._2 - 1)) * getValue((curPos._1 - 2, curPos._2 - 2)) * getValue((curPos._1 - 3, curPos._2 - 3))

    val upRight = getValue(curPos) * getValue((curPos._1 - 1, curPos._2 + 1)) * getValue((curPos._1 - 2, curPos._2 + 2)) * getValue((curPos._1 - 3, curPos._2 + 3))

    val downLeft = getValue(curPos) * getValue((curPos._1 + 1, curPos._2 - 1)) * getValue((curPos._1 + 2, curPos._2 - 2)) * getValue((curPos._1 + 3, curPos._2 - 3))

    val downRight = getValue(curPos) * getValue((curPos._1 + 1, curPos._2 + 1)) * getValue((curPos._1 + 2, curPos._2 + 2)) * getValue((curPos._1 + 3, curPos._2 + 3))

    val max = List(up, down, left, right, upLeft, upRight, downLeft, downRight).max

    val newMax = if (max > curGreatestProduct) max else curGreatestProduct

    if (nextPosition._1 >= 20) newMax
    else problem11(nextPosition, newMax)
  }

  /**
   * Problem 12
   * What is the value of the first triangle number to have over five hundred divisors?
   */

  def problem12(curPos: Long = 1): Long = {
    val curTriangleNumber = List.range(1.toLong, curPos + 1, 1.toLong).sum

    /**
     * Accessory Functions
     */
    def calcDivisors(curFactor: Long = 1, factors: List[Long] = Nil): Int = {
      val newFactors = if (curTriangleNumber % curFactor == 0) curFactor +: (curTriangleNumber / curFactor) +: factors else factors
      if (curFactor >= Math.sqrt(curTriangleNumber)) newFactors.size
      else calcDivisors(curFactor + 1, newFactors)
    }

    if (calcDivisors() > 500) curTriangleNumber
    else problem12(curPos + 1)
  }

  /**
   * Problem 13
   * Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.
   */

  def problem13(curRemainder: String = "0", currentList: List[String] = models.Euler.problem13Data): String = {

    /**
     * Accessory Functions
     */

    val nextSum = (currentList.map(_.takeRight(10).toLong).sum + curRemainder.toLong).toString

    if (currentList.headOption.map(_.length).getOrElse(0) < 20) nextSum.take(10)
    else problem13(if (nextSum.length <= 10) "0" else nextSum.take(nextSum.length - 10), currentList.map(s => s.take(s.length - 10)))

  }

  /**
   * Problem 14
   * Longest Collatz sequence under one million
   */
  def problem14(curStartingNumber: Long = 2, curSeqNumber: Long = 2, seqCount: Long = 1, highestSeqStartingNumberAndCount: (Long, Long) = (2, 1)): Long = {
    /**
     * Accessory Functions
     */

    if (curStartingNumber >= 1000000) highestSeqStartingNumberAndCount._1
    else {
      val nextSeqNumber = if (curSeqNumber % 2 == 0) curSeqNumber / 2 else (3 * curSeqNumber) + 1
      val nextSeqCount = seqCount + 1
      if (nextSeqNumber == 1) {
        val nextHighestSeqStartingNumber = if (nextSeqCount > highestSeqStartingNumberAndCount._2) (curStartingNumber, nextSeqCount) else highestSeqStartingNumberAndCount
        problem14(curStartingNumber + 1, curStartingNumber + 1, 1, nextHighestSeqStartingNumber)
      } else problem14(curStartingNumber, nextSeqNumber, nextSeqCount, highestSeqStartingNumberAndCount)
    }
  }

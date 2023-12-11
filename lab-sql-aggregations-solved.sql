
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	-- - 1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
    USE sakila;
    SELECT max(length) AS max_duration , min(length) AS min_duration FROM film;
    
	-- - 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
    SELECT CONCAT((avg(length))DIV 60, ' hours and ' , FLOOR((Avg(length)) %60) ,' mins') AS 'Average movie duration' FROM film;
   --    - *Hint: Look for floor and round functions.*
   
-- 2. You need to gain insights related to rental dates:
	-- - 2.1 Calculate the **number of days that the company has been operating**.
	-- - *Hint: To do this, use the `rental` table, and the `DATEDIFF()` function to subtract the earliest date in the `rental_date` column from the latest date.*

	SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS 'Number of days of operation' FROM rental;


    -- - 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
	SELECT *, MONTHNAME(rental_date) AS 'Month' , DAYNAME(rental_date) AS 'Weekday' FROM rental
    LIMIT 20;

    -- - 2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.*
	SELECT * ,
    CASE 
    WHEN WEEKDAY(rental_date) IN (5,6) THEN 'weekend'
	ELSE 'workday'
    END AS DAY_TYPE
    FROM rental;
	-- *Hint: use a conditional expression.*
    
 -- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the **film titles and their rental duration**. If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results of the film title in ascending order.
   --  - *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
   -- - *Hint: Look for the `IFNULL()` function.*
   
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

 -- *Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the **concatenated first and last names of customers**, along with the **first 3 characters of their email** address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.*
SELECT CONCAT(first_name, last_name) AS 'Customer Name' , left(email,3) AS 'Email start' FROM customer
ORDER BY last_name;

## Challenge 2
 -- Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
	-- - 1.1 The **total number of films** that have been released.
SELECT COUNT(*) AS 'Number of films released' FROM film;

	--  1.2 The **number of films for each rating**.
SELECT rating, COUNT(rating) AS 'Amount' FROM film
GROUP by rating;

	--  1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
SELECT rating, COUNT(rating) AS 'Amount' FROM film
GROUP by rating
ORDER BY COUNT(rating) DESC;

	-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
 -- Using the `film` table, determine:
   --  2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) AS 'Mean film duration' FROM film
GROUP by rating
ORDER BY ROUND(AVG(length),2) DESC;	

    -- 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2) AS 'Mean film duration' FROM film
GROUP by rating
HAVING AVG(length)>120
ORDER BY ROUND(AVG(length),2) DESC;	

-- 3. *Bonus: determine which last names are not repeated in the table `actor`.*
SELECT last_name, COUNT(last_name) AS 'count' FROM actor
GROUP BY last_name
HAVING COUNT(last_name) =1
ORDER BY last_name;
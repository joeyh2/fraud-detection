-- How can we isolate the transactions of each cardholder?
SELECT *
FROM transaction
INNER JOIN credit_card
  ON credit_card.card = transaction.card

INNER JOIN card_holder
  ON credit_card.cardholder_id = card_holder.id

ORDER BY card_holder.name;

-- Count the transactions that are less than 2.00 USD per cardholder.
SELECT card_holder.name, COUNT(card_holder.name)
FROM transaction
INNER JOIN credit_card
  ON credit_card.card = transaction.card
INNER JOIN card_holder
  ON credit_card.cardholder_id  = card_holder.id
WHERE transaction.amount <= 2
GROUP BY card_holder.name
ORDER BY COUNT DESC;

-- What are the top 100 highest transactions made between 7:00 am and 9:00 am?
SELECT ROUND((amount), 2)
FROM transaction
WHERE DATE_PART('hour', date)>=7 AND DATE_PART('hour', date)<9
ORDER BY amount DESC
LIMIT 100;

-- Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
SELECT ROUND((amount,2)
FROM transaction
WHERE DATE_PART('hour', date)<=7 OR DATE_PART('hour', date)>9
ORDER BY amount DESC
LIMIT 100;

--What are the top 5 merchants prone to being hacked using small transactions?
SELECT name, COUNT(amount<2)
FROM merchant
INNER JOIN transaction
ON transaction.id_merchant = merchant.id
GROUP BY name
ORDER BY COUNT(amount<2) DESC
LIMIT 5;
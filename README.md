# Analysis of Amazon Reviews On Electronics

## Introduction
The purpose of the project was to assess the trustworthiness of reviewers in Amazon's Vine program. A [dataset](https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Electronics_v1_00.tsv.gz) of Amazon reviews on electronics from Vine (V; paid) and non-Vine (NV; un-paid) reviewers was used. The dataset was cleaned, transformed, and loaded into a PostgreSQL database for analysis via SQL queries (see [ETL PySpark script](https://colab.research.google.com/drive/1GBQekxmvJoOzn_ma-y8UWk1SIRmEpm8V?usp=sharing), [PostgreSQL database schema](analysis/schema.sql), and [SQL queries](analysis/queries.sql)).

For context on the dataset, there were 3,093,861 reviews in total from June 9, 1999 to August 31, 2015. The dataset did not include duplicate review IDs or reviews with null values in place of review ID, customer ID, or product ID. Reviews where the reviewer did not identify as V or NV were excluded. 

To assess trustworthiness of reviewers, three potential features of the dataset were explored. First, did the dataset show results expected of having un-paid and paid reviewers? (These results wouldn't necessarily mean that paid reviewers are untrustworthy. Rather, they would indicate that people are being paid.) The other two potential features of the dataset would be results supportive of trustworthy behaviour, and results supportive of untrustworthy behaviour.

## Results & Discussion
As expected, there were more NV than V reviews (99.4% of total reviews (3,075,349 reviews) compared to 0.6% (18,512 reviews), respectively). However, on average, V reviewers were more prolific than NV reviewers. (Average number of reviews per reviewer was 18 vs. 3, respectively.) Both results are expected for a population consisting of paid and upaid reviewers and are not indicative of trustworthiness or otherwise.

If V reviewers are trustworthy, then ideally, they would have the same average star rating for products as NV reviewers, but they would have more "helpful votes" per review. (A helpful vote is a vote from a member of the general public, indicating that the review was helpful.) Both scenarios were true for this dataset. The average star rating per review was 4 for both V and NV reviews. Also, the average number of helpful votes per review was 6 vs. 2 for V vs. NV, respectively. Even if the threshold is increased to each review having 30 or more "total votes" (total votes being the number of votes each review received), V reviews had more helpful votes per review (91 vs. 78 for NV). 

If V reviewers are untrustworthy, they would be expected to rate products more favourably (more 4-5 star ratings vs. 1-2 star ratings). Analysis shows that V reviewers do give slightly more 4-5 star ratings than NV (3.9% more V reviews receive 4-5 star ratings compared to NV reviews). Also, they give less 1-2 star ratings than NV (10.5% less). 

Additional insight is gained, however, from breaking the analysis down to each star rating. For 5 star rating, there are 14.2% more NV reviews (total of 1,773,112 NV vs. 8,044 V reviews); for 4 star, there are 18.1% more V reviews; for 3 star, there are 6.6% more V reviews; and for 2 or 1 star, the differences between number of reviews is small (0.6 to 0.8%). These results show that NV reviewers are more likely to give the highest praise (5 star rating) to a product, and that V reviewers tend to be more muted in their praise (they tend to give more 4 star ratings).

## Conclusion
Whether V reviewers are trustworthy probably doesn't deserve a yes/no answer. Conclusions that may be drawn from these results are that V reviewers tend to give more helpful reviews but that they 'shy away' from giving the highest (5 star) and the lowest (1-2 star) ratings. One can speculate on why. Perhaps V reviewers put more thought into their reviews since they're paid, in particular, giving reasons why a product is good or bad, compared to NV reviewers. This may result in people thinking that their reviews are more helpful. Perhaps V reviewers are less likely to grant a 5 star rating because they are concerned that their review won't be believed, so they opt for a 4 star rating. Perhaps NV reviewers are more likely to rate at the extreme ends of the spectrum (5 or 1-2 star ratings) because they are more likely to take time to rate a product when they love or hate it. 

Thus, a consumer approach to shopping for electronics on Amazon may be to pay more attention when there are extreme star ratings (5 or 1-2 star) because, probably, unincentived reviewers thought the product was great or horrible and took time to make their thoughts known. Also, the consumer may do well to read the written reviews more carefully for products with 4-3 star ratings since paid reviewers likely took time to provide helpful reviews. 

## Resources
- [Amazon electronics reviews dataset](https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Electronics_v1_00.tsv.gz) 
- [Amazon dataset instructions](https://s3.amazonaws.com/amazon-reviews-pds/tsv/index.txt)
- [ETL PySpark script](https://colab.research.google.com/drive/1GBQekxmvJoOzn_ma-y8UWk1SIRmEpm8V?usp=sharing)
- PostgreSQL database schema: [schema.sql](analysis/schema.sql)
- SQL queries: [queries.sql](analysis/queries.sql)
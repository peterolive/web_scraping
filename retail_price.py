from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import csv
import re

# this selenium script is used to scrape the retail price of sneakers
driver = webdriver.Chrome()

driver.get("https://stockx.com/retro-jordans/release-date?size_types=men&years=2011,2010,2009,2008")

csv_file = open('shoes_2008.csv', 'w')
writer = csv.writer(csv_file)

# there is a "load more" button at the bottom of the page, 
# the following codes were used to click the button until webpage does not have the "load more" button any more
while True:
	try:
		time.sleep(3)
		wait_button = WebDriverWait(driver, 10)
		current_button = wait_button.until(EC.element_to_be_clickable((By.XPATH,
									'//button[@class="btn btn-default"]')))
		current_button.click()
	except Exception as e:
		break



prev_button = None
current_button = None
while True:
	try:
		
		elements = driver.find_elements_by_xpath('//a[@class="tile browse-tile"]')
		#print(elements)
		links = []
		for i in range(len(elements)):
			links.append(elements[i].get_attribute('href'))
		

		for link in links:
			print('navigating to: ' + link)
			driver.get(link)
			link_dict = {}
			if len(driver.find_elements_by_xpath('.//div[@class="product-details detail-row"]/div/span')) != 4:
				continue
			else:
				time.sleep(3)
				name = driver.find_element_by_xpath('//div[@class="col-md-12"]//h1[@class="name"]').text
				print(name)
				retail_price = driver.find_element_by_xpath('.//div[@class="product-details detail-row"]/div[3]/span').text
				print(retail_price)
				release_date = driver.find_element_by_xpath('.//div[@class="product-details detail-row"]/div[4]/span').text
				print(release_date)
				
				details = driver.find_elements_by_xpath('.//div[@class="gauge-value"]')

				details_list = []

				for x in details:
					details_list.append(x.text)
				sales = details_list[0]
				print(sales)
				percentage = details_list[1]
				print(percentage)
				resell_price = details_list[2]
				print(resell_price)

				link_dict['name'] = name
				link_dict['retail_price'] = retail_price
				link_dict['release-date'] = release_date
				link_dict['sales'] = sales 
				link_dict['percentage'] = percentage
				link_dict['resell_price'] = resell_price

				writer.writerow(link_dict.values())

			driver.back()

	except Exception as e:
		print(e)
		csv_file.close()
		driver.close()
		break

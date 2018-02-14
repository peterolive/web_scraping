from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import csv
import re

# Windows users need to specify the path to chrome driver you just downloaded.
# You need to unzip the zipfile first and move the .exe file to any folder you want.
# driver = webdriver.Chrome(r'path\to\the\chromedriver.exe')
driver = webdriver.Chrome()
# Go to the page that we want to scrape
driver.get("https://stockx.com/retro-jordans/release-date?size_types=men&years=2011,2010,2009,2008")

csv_file = open('shoes_2008.csv', 'w')
writer = csv.writer(csv_file)


while True:
	try:
		time.sleep(3)
		wait_button = WebDriverWait(driver, 10)
		current_button = wait_button.until(EC.element_to_be_clickable((By.XPATH,
									'//button[@class="btn btn-default"]')))
		current_button.click()
	except Exception as e:
		break





# Page index used to keep track of where we are.
#index = 1
# We want to start the first two pages.
# If everything works, we will change it to while True
prev_button = None
current_button = None
while True:
	try:
		# if prev_button is not None:
		# 	WebDriverWait(driver, 10).until(EC.staleness_of(prev_button))

		#print("Scraping Page number " + str(index))
		#index = index + 1
		#wait_review = WebDriverWait(driver, 10)
		# Find all the reviews. The find_elements function will return a list of selenium select elements.
		# Check the documentation here: http://selenium-python.readthedocs.io/locating-elements.html
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
				#bid = driver.find_elements_by_xpath('.//div[@class="stat-value stat-small"]')
				#qq = []
				#for x in bid:
				#	qq.append(x.text)
				#bid1 = qq[2]
				#print(bid1)
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

# do stuff within that page here...
			driver.back()

#//following-sibling::h3[contains(text(), "Lowest Ask")]
		#driver.get("https://stockx.com/retro-jordans/release-date?years=2017&size_types=men")
		#wait_button = WebDriverWait(driver, 10)
		#current_button = driver.find_element_by_xpath('//div[@class="browse-load-more"]/button[@class="btn btn-default"]')
		#current_button = wait_button.until(EC.element_to_be_clickable((By.XPATH,
		#							'//button[@class="btn btn-default"]')))
		#prev_button = current_button
		#current_button.click()
		# Locate the next button element on the page and then call `button.click()` to click it.
		# button = # Your code here
		# button.click()

	except Exception as e:
		print(e)
		csv_file.close()
		driver.close()
		break

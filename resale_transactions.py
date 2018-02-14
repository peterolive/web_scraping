from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import csv
import re

# this selenium script was used to scrape the sneakers resale transactions 
driver = webdriver.Chrome()

driver.get("https://stockx.com/retro-jordans/release-date?size_types=men&years=2013,2012,2011")

csv_file = open('shoes_size2013.csv', 'w')
writer = csv.writer(csv_file)

# there is a "load more" button at the bottom of the page, 
# the following codes were used to click the button until webpage does not have the "load more" button any more
while True:
	try:
		time.sleep(2)
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
				try:
					wait = driver.find_element_by_xpath('//li//a[@style="outline:none;"]').text
					if wait == ('Login / Sign Up'):
						time.sleep(30)
						print('waiting...')
					else:
						time.sleep(0)
				except:
					pass

				name = driver.find_element_by_xpath('//div[@class="col-md-12"]//h1[@class="name"]').text
				print(name)

				# retail_price = driver.find_element_by_xpath('.//div[@class="product-details detail-row"]/div[3]/span').text
				# print(retail_price)
				# release_date = driver.find_element_by_xpath('.//div[@class="product-details detail-row"]/div[4]/span').text
				# print(release_date)
				#bid = driver.find_elements_by_xpath('.//div[@class="stat-value stat-small"]')
				#qq = []
				#for x in bid:
				#	qq.append(x.text)
				#bid1 = qq[2]
				#print(bid1)
				# details = driver.find_elements_by_xpath('.//div[@class="gauge-value"]')

				# details_list = []

				# for x in details:
				# 	details_list.append(x.text)
				# sales = details_list[0]
				# print(sales)
				# percentage = details_list[1]
				# print(percentage)
				# resell_price = details_list[2]
				# print(resell_price)
				time.sleep(5)
				text = driver.find_element_by_xpath('//div[@class="market-history-sales"]/a[@class="all"]')
				text.click()
				time.sleep(1)
				history_sales = driver.find_elements_by_xpath('//table[@class="activity-table table table-condensed table-striped "]/tbody//tr')
				for history_sale in history_sales:
					try:
						sale_date = history_sale.find_element_by_xpath('./td[1]').text
						size = history_sale.find_element_by_xpath('./td[3]').text
						sale_price = history_sale.find_element_by_xpath('./td[4]').text
					except:
						pass
					print(sale_date)



					link_dict['name'] = name
					link_dict['sale_date'] = sale_date
					link_dict['size'] = size
					link_dict['sale_price'] = sale_price

					writer.writerow(link_dict.values())

			driver.back()

	except Exception as e:
		print(e)
		csv_file.close()
		driver.close()
		break

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import time
browser = webdriver.Chrome()

try:
    browser.get("https://magento.softwaretestingboard.com/")
    button = browser.find_element(By.XPATH, '//*[@id="maincontent"]/div[3]/div/div[2]/div[1]/a/span/span[2]').click()
    element1 = browser.find_element(By.CSS_SELECTOR,'[href="https://magento.softwaretestingboard.com/fiona-fitness-short.html"]')
    element1.click()
    browser.implicitly_wait(3)
    razmer = browser.find_element(By.ID,"option-label-size-143-item-171")
    razmer.click()
    color = browser.find_element(By.ID,'option-label-color-93-item-49')
    color.click()
    qty = browser.find_element(By.CSS_SELECTOR,'[type="number"]')
    qty.clear()
    qty.send_keys("3")
    button2 = browser.find_element(By.XPATH,'//*[@id="product-addtocart-button"]/span').click()
    pismo = browser.find_element(By.XPATH,'//*[@id="maincontent"]/div[1]/div[2]/div/div/div').text
    assert pismo == 'You added Fiona Fitness Short to your shopping cart.'






    time.sleep(5)
finally:
  browser.quit()
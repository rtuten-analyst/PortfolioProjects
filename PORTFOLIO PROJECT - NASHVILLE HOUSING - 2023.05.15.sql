
-- Portfolio Project - CLEANING: Nashville Housing data


SELECT * 
FROM PortfolioProject.dbo.nashville_housing



--------------------------------------------------------------------------------------------------------------------------------
-- SaleDate originally in DateTime format. We only require the Date portion.
SELECT SaleDate, CONVERT(Date, SaleDate)
FROM PortfolioProject.dbo.nashville_housing

-- Datetime field has been converted to Date
UPDATE nashville_housing
SET SaleDate =CONVERT(Date, SaleDate)

--ALTER TABLE nashville_housing
--ADD SaleDateConverted Date

--UPDATE nashville_housing
--SET SaleDateConverted =CONVERT(Date, SaleDate)



--------------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address Data - We have NULL values in PropertyAddress
SELECT *
FROM PortfolioProject.dbo.nashville_housing
-- WHERE PropertyAddress IS NULL
-- Notice ParcelID appears to reference Property Address. If one ParcelID has an address and another (same ParcelID) does not - populate with address of previous.
ORDER BY ParcelID


-- Using a SELF JOIN for reference
-- Where PropertyAddress is NULL, we want to populate it from the b.PropertyAddress column. First we select for accuracy, then later we update.
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.nashville_housing as a
JOIN PortfolioProject.dbo.nashville_housing as b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL


-- Note, we will need to update using the alias 'a' rather than the Table name since the join would 'confuse' what to update.
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.nashville_housing as a
JOIN PortfolioProject.dbo.nashville_housing as b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL
-- After running this query, the 30 nulls have been updated to contain address values.

--------------------------------------------------------------------------------------------------------------------------------
-- Break Address into individual columns (Address, City, State)
-- Address has a comma delimiter from Address, City
SELECT PropertyAddress
FROM PortfolioProject.dbo.nashville_housing


-- Start selection from first value up until the first comma instance. (-1 at the end to exclude the comma from output by reducing the ending index positon by 1)
SELECT
-- Start selection from first value up until the first comma instance. (-1 at the end to exclude the comma from output by reducing the ending index positon by 1)
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS address,
-- Start selection at the first comma instance, + 1. THEN extract the remaining characters to the end (LEN(PropertyAddress))
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS address
FROM PortfolioProject.dbo.nashville_housing




-- CREATE Address column - Update Address column
ALTER TABLE nashville_housing
ADD PropertySplitAddress NVARCHAR(255)

UPDATE nashville_housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)



-- Create City column - Update City column
ALTER TABLE nashville_housing
ADD PropertySplitCity NVARCHAR(255)

UPDATE nashville_housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) 


-- Check
SELECT * FROM nashville_housing

-- This column contains NULL values - Avoiding SUBSTRING this time to 'fix'
SELECT OwnerAddress FROM PortfolioProject.dbo.nashville_housing


------------------------------------------------------------------------------------------------------
-- Second approach to cleaning up an Address-type column
-- Notice PARSENAME sort of does the opposite of what we imagine. Seperating out values by delimiter (.). We replaced ',' with '.' to make this work.
SELECT
PARSENAME(REPLACE(OwnerAddress, ',','.'), 3) AS Address,
PARSENAME(REPLACE(OwnerAddress, ',','.'), 2) AS City,
PARSENAME(REPLACE(OwnerAddress, ',','.'), 1) AS State
FROM PortfolioProject.dbo.nashville_housing


-- TABLES: Adding new columns from splitting OwnerAddress
ALTER TABLE nashville_housing
ADD 
	owner_split_address NVARCHAR(255),
	owner_split_city NVARCHAR(255),
	owner_split_state NVARCHAR(255)


SELECT * FROM PortfolioProject.dbo.nashville_housing


-- TABLES: Update new columns from splitting OwnerAddress
UPDATE nashville_housing
SET
	owner_split_address = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3),
	owner_split_city = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2),
	owner_split_state = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)



-----------------------------------------------------------------------------------------------------------------
-- Cleaning 'SoldAsVacant' colmumn
SELECT
	DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.nashville_housing
GROUP BY SoldAsVacant
ORDER BY 2
-- Changing Y -> Yes, N -> No


SELECT SoldAsVacant,
	CASE 
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant -- This basically means keep the field as-is, referencing itself.
	END
FROM PortfolioProject.dbo.nashville_housing



-- Updating field using previous CASE query.
UPDATE nashville_housing
SET SoldAsVacant = 
	CASE 
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant -- This basically means keep the field as-is, referencing itself.
	END



-- Check - Cleared! Only Yes/No
SELECT
	DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.nashville_housing
GROUP BY SoldAsVacant
ORDER BY 2


--------------------------------------------------------------------------------------------------------------------
-- Removing Duplicates

-- Creating a CTE to partition data and label the number of rows that contains like data.
WITH RowNumCTE AS(
SELECT 
	*, 
	ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID) row_num
FROM PortfolioProject.dbo.nashville_housing
) -- Selecting data from our CTE that have more than 1 row of partitioned data (potential duplicate)
SELECT * --(Swapping SELECT * with DELETE to remove Duplicates)
--DELETE
FROM RowNumCTE 
WHERE row_num > 1
-- Rerun the SELECTION query - there are no duplicates. Huzzah



--------------------------------------------------------------------------------------------------------------------
-- Delete unused columns
SELECT * FROM PortfolioProject.dbo.nashville_housing


ALTER TABLE PortfolioProject.dbo.nashville_housing
DROP COLUMN
	OwnerAddress,
	TaxDistrict,
	PropertyAddress
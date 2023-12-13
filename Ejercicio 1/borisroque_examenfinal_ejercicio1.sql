-- 			 INF 317             
-- 		  EXAMEN  FINAL
--         EJERCICIO 1

-- NOMBRES Y APELLIDOS: BORIS ORLANDO ROQUE HUANCA
-- CI.: 9868420 LP

CREATE DATABASE ExamenFinal_BorisRoque;

/*LISTADO DE PRODUCTOS*/
SELECT P.ProductID, P.Name
FROM Production.Product P
ORDER BY P.ProductID ASC
-- PARA IDENTIFICAR LA LLAVE PRIMARIA:
CONSTRAINT PKPRODUCTO PRIMARY KEY ([ProductID])

/*LISTADO DE CATEGORIAS*/
SELECT C.ProductCategoryID, C.Name
FROM Production.ProductCategory C
ORDER BY C.ProductCategoryID ASC
-- PARA IDENTIFICAR LA LLAVE PRIMARIA:
CONSTRAINT PKCAT PRIMARY KEY ([ProductCategoryID])

 /* LISTADO TABLA TIEMPO */
 SELECT DISTINCT MONTH(S.OrderDate) as MES, YEAR(S.OrderDate) as ANIO
 FROM Sales.SalesOrderHeader S
 ORDER BY 1 ASC, 2 ASC
 -- PARA IDENTIFICAR LA LLAVE PRIMARIA:
 CONSTRAINT PKTIEMPO PRIMARY KEY ([MES], [ANIO])

 /*LISTADO DE TERRITORIOS*/
 SELECT T.TerritoryID, T.Name
 FROM Sales.SalesTerritory T
 ORDER BY T.TerritoryID ASC
 -- PARA IDENTIFICAR LA LLAVE PRIMARIA:
 CONSTRAINT PKTERRITORIO PRIMARY KEY ([TerritoryID])

 /*LISTADO DE EMPLEADOS*/
 SELECT HE.BusinessEntityID, HE.JobTitle, PP.FirstName, PP.LastName 
 FROM Sales.SalesPerson E 
 INNER JOIN HumanResources.Employee HE
 ON HE.BusinessEntityID = E.BusinessEntityID 
 INNER JOIN Person.Person PP
 ON PP.BusinessEntityID = HE.BusinessEntityID
 ORDER BY HE.BusinessEntityID ASC
 -- PARA IDENTIFICAR LA LLAVE PRIMARIA:
 CONSTRAINT PKEMPLEADO PRIMARY KEY ([BusinessEntityID])

 /*--------------------------------------------------------------------------------------------------------------------*/

 /*TABLA DE VENTAS (HECHOS)*/
 SELECT SP.BusinessEntityID, P.ProductID, PC.ProductCategoryID, T.TerritoryID, MONTH(S.OrderDate) AS Mes, YEAR(S.OrderDate) AS Anio, SUM(D.UnitPrice * D.OrderQty) AS Monto
 FROM Sales.SalesOrderHeader S
 INNER JOIN Sales.SalesOrderDetail D
 ON S.SalesOrderID = D.SalesOrderID
 INNER JOIN Production.Product P
 ON P.ProductID = D.ProductID
 INNER JOIN Sales.SalesTerritory T
 ON T.TerritoryID = S.TerritoryID
 INNER JOIN Sales.SalesPerson SP
 ON SP.BusinessEntityID = S.SalesPersonID
 INNER JOIN Production.ProductCategory PC
 ON PC.ProductCategoryID = P.ProductSubcategoryID
 GROUP BY SP.BusinessEntityID, P.ProductID, PC.ProductCategoryID, T.TerritoryID, MONTH(S.OrderDate), YEAR(S.OrderDate)
 ORDER BY YEAR(S.OrderDate) ASC, MONTH(S.OrderDate) ASC; 

 /*CODIGO PARA AÑADIR LAS LLAVES FORANEAS A LA TABLA DE HECHOS*/
 CONSTRAINT FKEMPLEADO FOREIGN KEY ([BusinessEntityID])
 REFERENCES DIM_EMPLEADO_DESTINO([BusinessEntityID]),
 CONSTRAINT FKPRODUCTO FOREIGN KEY ([ProductID])
 REFERENCES DIM_PRODUCTO_DESTINO([ProductID]),
 CONSTRAINT FKCATEGORIA FOREIGN KEY ([ProductCategoryID])
 REFERENCES DIM_CATEGORIA_DESTINO([ProductCategoryID]),
 CONSTRAINT FKTERROTORIO FOREIGN KEY ([TerritoryID])
 REFERENCES DIM_TERRITORIO_DESTINO([TerritoryID]),
 CONSTRAINT FKTIEMPO FOREIGN KEY ([MES], [ANIO])
 REFERENCES DIM_TIEMPO_DESTINO([MES], [ANIO])





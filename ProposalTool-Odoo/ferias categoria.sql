SELECT    ( Min(`a1`.`created_at`) + INTERVAL -(5) hour )                      AS `fecha_orden`, 
          `a4`.`increment_id`                                                  AS `numero_orden`, 
          `a1`.`name`                                                          AS `producto`, 
          Round(`a1`.`qty_ordered`, 0)                                         AS `cantidad`, 
          `a3`.`label`                                                         AS `estatus`, 
          `a5`.`comment`                                                       AS `comentarios`, 
          `a8`.`name`                                                          AS `feria`, 
          (( Min(`a1`.`created_at`) + INTERVAL 8 week ) + INTERVAL -(5) hour ) AS `fecha_entrega` 
FROM      `eydsys03_magento`.`ca_sales_flat_order_item` `a1` 
JOIN      `eydsys03_magento`.`ca_sales_flat_order_status_history` `a2` 
ON       (
                              `a1`.`order_id` = `a2`.`parent_id` )
JOIN      `eydsys03_magento`.`ca_sales_order_status` `a3` 
ON       ( 
                              `a2`.`status` = `a3`.`status` ) 
JOIN      `eydsys03_magento`.`ca_sales_flat_order_grid` `a4` 
ON       ( 
                              `a1`.`order_id` = `a4`.`entity_id` )
LEFT JOIN `eydsys03_magento`.`comentarios` `a5` 
ON       ( 
                              `a1`.`order_id` = `a5`.`parent_id` ) 
JOIN      `eydsys03_magento`.`last_status` `a6` 
ON       ( 
                              `a1`.`order_id` = `a6`.`parent_id`  
          AND        
                              `a2`.`created_at` = `a6`.`created_at` ) 
JOIN      `eydsys03_magento`.`ca_catalog_category_product` `a7` 
ON        ( 
                    `a1`.`product_id` = `a7`.`product_id`) 
JOIN      `eydsys03_magento`.`ca_simipos_location` `a8` 
ON       ( 
                              `a4`.`location_id` = `a8`.`location_id`)
where `a7`.`category_id` = 73 
GROUP BY `a1`.`order_id`, `a1`.`name`, `a1`.`qty_ordered`, `a8`.`name`
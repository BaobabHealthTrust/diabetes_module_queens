class Reports::Cohort

  attr_accessor :start_date, :end_date

  # Initialize class
  def initialize(start_date, end_date)
    @start_date = "#{start_date}" # 00:00:00"
    @end_date = "#{end_date}" # 23:59:59"
  end

  # Model access test function
  def specified_period
    @range = [@start_date, @end_date]
  end

  # Get all patients registered in specified period
  def total_registered
    @patients = Patient.find(:all, :conditions => 
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? AND voided = 0",
        @start_date, @end_date]).length
  end

  def total_adults_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? AND " +
          "COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) >= 15 AND patient.voided = 0",
        @start_date, @end_date]).length
  end

  def total_children_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? AND " +
          "COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) <= 14 AND patient.voided = 0",
        @start_date, @end_date]).length
  end

  def total_men_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? \
          AND UCASE(person.gender) = ? AND patient.voided = 0",
        @start_date, @end_date, "M"]).length
  end

  def total_adult_men_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? \
          AND UCASE(person.gender) = ? AND COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) >= 15 AND patient.voided = 0",
        @start_date, @end_date, "M"]).length
  end

  def total_boy_children_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? \
          AND UCASE(person.gender) = ? AND COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) <= 14 AND patient.voided = 0",
        @start_date, @end_date, "M"]).length
  end

  def total_women_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? \
          AND UCASE(person.gender) = ? AND patient.voided = 0",
        @start_date, @end_date, "F"]).length
  end

  def total_adult_women_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? \
          AND UCASE(person.gender) = ? AND COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) >= 15 AND patient.voided = 0",
        @start_date, @end_date, "F"]).length
  end

  def total_girl_children_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= ? AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ? \
          AND UCASE(person.gender) = ? AND COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) <= 14 AND patient.voided = 0",
        @start_date, @end_date, "F"]).length
  end

  # Get all patients ever registered
  def total_ever_registered
    @patients = Patient.find(:all, :conditions => ["patient.voided = 0 AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?",
        @end_date]).collect{|p| p.patient_id}.uniq.length
  end

  def total_adults_ever_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions => 
        ["COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) >= 15 AND patient.voided = 0 AND \
        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?", @end_date]).length
  end

  def total_children_ever_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) <= 14 AND patient.voided = 0 AND \
        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?", @end_date]).length
  end

  def total_men_ever_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions => ["person.gender = ? \
    AND patient.voided = 0 AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?", "M", @end_date]).length
  end

  def total_adult_men_ever_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions => 
        ["person.gender = ? AND COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) >= 15 AND patient.voided = 0 \
         AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?", "M", @end_date]).length
  end

  def total_boy_children_ever_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions => 
        ["person.gender = ? AND COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) <= 14 AND patient.voided = 0 \
         AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?", "M", @end_date]).length
  end

  def total_women_ever_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions => ["person.gender = ? AND patient.voided = 0 \
         AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?", "F", @end_date]).length
  end

  def total_adult_women_ever_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["person.gender = ? AND COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) >= 15 AND patient.voided = 0 \
         AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?", "F", @end_date]).length
  end

  def total_girl_children_ever_registered
    @patients = Patient.find(:all, :joins => [:person], :conditions =>
        ["person.gender = ? AND COALESCE(DATEDIFF(NOW(), person.birthdate)/365, 0) <= 14 AND patient.voided = 0 \
         AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= ?", "F", @end_date]).length
  end

  # Oral Treatments
  def oral_treatments_ever
    ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient
                                  WHERE patient_id IN
                                    (SELECT DISTINCT patient_id FROM orders
                                      WHERE order_id IN
                                        (SELECT order_id FROM drug_order
                                          WHERE drug_inventory_id IN
                                            (SELECT drug_id FROM drug d WHERE name LIKE '%metformin%' OR
                                      name LIKE '%glibenclamide%')))
                                  AND NOT patient_id IN (SELECT DISTINCT patient_id FROM orders
                                      WHERE order_id IN
                                    (SELECT order_id FROM drug_order
                                      WHERE drug_inventory_id IN
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%insulin%'))) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0
                                        AND patient.patient_id IN (#{ids})").length
  end

  def oral_treatments
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient
                                  WHERE patient_id IN
                                    (SELECT DISTINCT patient_id FROM orders
                                      WHERE order_id IN
                                        (SELECT order_id FROM drug_order
                                          WHERE drug_inventory_id IN
                                            (SELECT drug_id FROM drug d WHERE name LIKE '%metformin%' OR
                                      name LIKE '%glibenclamide%')))
                                  AND NOT patient_id IN (SELECT DISTINCT patient_id FROM orders
                                      WHERE order_id IN
                                    (SELECT order_id FROM drug_order
                                      WHERE drug_inventory_id IN
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%insulin%'))) \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Insulin
  def insulin_ever
    ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient
                                  WHERE NOT patient_id IN
                                    (SELECT DISTINCT patient_id FROM orders
                                      WHERE order_id IN
                                        (SELECT order_id FROM drug_order
                                          WHERE drug_inventory_id IN
                                            (SELECT drug_id FROM drug d WHERE name LIKE '%metformin%' OR
                                      name LIKE '%glibenclamide%')))
                                  AND patient_id IN (SELECT DISTINCT patient_id FROM orders
                                      WHERE order_id IN
                                    (SELECT order_id FROM drug_order
                                      WHERE drug_inventory_id IN
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%insulin%'))) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0
                                        AND patient.patient_id IN (#{ids})").length
  end

  def insulin
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient
                                  WHERE NOT patient_id IN
                                    (SELECT DISTINCT patient_id FROM orders
                                      WHERE order_id IN
                                        (SELECT order_id FROM drug_order
                                          WHERE drug_inventory_id IN
                                            (SELECT drug_id FROM drug d WHERE name LIKE '%metformin%' OR
                                      name LIKE '%glibenclamide%')))
                                  AND patient_id IN (SELECT DISTINCT patient_id FROM orders
                                      WHERE order_id IN
                                    (SELECT order_id FROM drug_order
                                      WHERE drug_inventory_id IN
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%insulin%'))) \
                                      AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  # Oral and Insulin
  def oral_and_insulin_ever
    ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient \
                                  WHERE patient_id IN \
                                    (SELECT DISTINCT patient_id FROM orders \
                                      WHERE order_id IN \
                                        (SELECT order_id FROM drug_order \
                                          WHERE drug_inventory_id IN \
                                            (SELECT drug_id FROM drug d WHERE name LIKE '%metformin%' OR \
                                      name LIKE '%glibenclamide%')))
                                  AND patient_id IN (SELECT DISTINCT patient_id FROM orders \
                                      WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%insulin%'))) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0
                                        AND patient.patient_id IN (#{ids})").length
  end

  def oral_and_insulin
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient \
                                  WHERE patient_id IN \
                                    (SELECT DISTINCT patient_id FROM orders \
                                      WHERE order_id IN \
                                        (SELECT order_id FROM drug_order \
                                          WHERE drug_inventory_id IN \
                                            (SELECT drug_id FROM drug d WHERE name LIKE '%metformin%' OR \
                                      name LIKE '%glibenclamide%')))
                                  AND patient_id IN (SELECT DISTINCT patient_id FROM orders \
                                      WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%insulin%'))) \
                                      AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  # Metformin
  def metformin_ever
     ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                  LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                  WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%metformin%')) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0
                                        AND patient.patient_id IN (#{ids})").length
  end

  def metformin
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                   LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                   WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%metformin%')) \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Glibenclamide
  def glibenclamide_ever
    ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                  LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                  WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%glibenclamide%')) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0
                                        AND patient.patient_id IN (#{ids})").length
  end

  def glibenclamide
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                   LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                   WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%glibenclamide%')) \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Lente Insulin
  def lente_insulin_ever
    ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                   LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                  WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%lente%' AND name LIKE '%insulin%')) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def lente_insulin
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                   LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                   WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%lente%' AND name LIKE '%insulin%')) \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Soluble Insulin
  def soluble_insulin_ever
    ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                   LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                  WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%soluble%' AND name LIKE '%insulin%')) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def soluble_insulin
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                   LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                   WHERE order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE name LIKE '%soluble%' AND name LIKE '%insulin%')) \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Background Retinopathy
  def background_retinapathy_ever
    ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs  \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'BACKGROUND RETINOPATHY') AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def background_retinapathy
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                   WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'BACKGROUND RETINOPATHY') \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Ploriferative Retinopathy
  def ploriferative_retinapathy_ever
    ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'PLORIFERATIVE RETINOPATHY') AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def ploriferative_retinapathy
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                   WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'PLORIFERATIVE RETINOPATHY') \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # End Stage Retinopathy
  def end_stage_retinapathy_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'END STAGE DISEASE') AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def end_stage_retinapathy
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                   WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'END STAGE DISEASE') \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Cataract
  def cataracts_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CATARACT') AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def cataracts
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                   WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CATARACT') \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Cataract
  def macrovascular_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MYOCARDIAL INFARCTION' OR name = 'ANGINA' \
                                      OR name = 'STROKE' OR name = 'PERIPHERAL VASCULAR DISEASE') AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def macrovascular
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                   WHERE value_coded IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MYOCARDIAL INFARCTION' OR name = 'ANGINA' \
                                      OR name = 'STROKE' OR name = 'PERIPHERAL VASCULAR DISEASE') \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # No complications
  def no_complications_ever
  ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
  #raise alive_ever.map{|p| p.patient_id}.to_yaml
    ids = ids.uniq.join(',') rescue ""
=begin
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                 (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MYOCARDIAL INFARCTION' OR name = 'ANGINA' \
                                      OR name = 'STROKE' OR name = 'PERIPHERAL VASCULAR DISEASE')) AND NOT \
                                    patient_id IN (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CATARACT')) AND NOT patient_id IN \
                                    (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'END STAGE DISEASE')) AND NOT patient_id IN \
                                  (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'PLORIFERATIVE RETINOPATHY')) AND NOT patient_id IN \
                                   (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'BACKGROUND RETINOPATHY'))").length
=end

    bgretinopathy = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'BACKGROUND RETINOPATHY')").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    plretinopathy = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'PLORIFERATIVE RETINOPATHY')").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    esretinopathy = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'END STAGE DISEASE')").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    cataract = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CATARACT')").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    pvd = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MYOCARDIAL INFARCTION' OR name = 'ANGINA' \
                                      OR name = 'STROKE' OR name = 'PERIPHERAL VASCULAR DISEASE')").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    maculopathy = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MACULOPATHY') OR UCASE(value_text) = 'MACULOPATHY'").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    numbness = Order.find_by_sql("SELECT DISTINCT person_id FROM obs WHERE value_coded = \
                                      (SELECT concept_id FROM concept_name where name = 'NUMBNESS SYMPTOMS') \
                                        AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                        ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG'))").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    amputation = Order.find_by_sql("SELECT DISTINCT person_id FROM obs WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name where name = 'AMPUTATION') \
                                      AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                        ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG'))").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    ulcers = Order.find_by_sql("SELECT DISTINCT person_id FROM obs WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name where name = 'CURRENT FOOT ULCERATION') \
                                      AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                      ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG'))").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    creatinine = Order.find_by_sql("SELECT DISTINCT person_id, value_numeric FROM obs \
                                    WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CREATININE') AND COALESCE(value_numeric, 0) >= 1.2").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    urine = Order.find_by_sql("SELECT DISTINCT person_id FROM obs WHERE concept_id = \
                                      (SELECT concept_id FROM concept_name WHERE name = 'URINE PROTEIN') \
                                          AND value_coded IN (SELECT concept_id FROM concept_name
                                          WHERE name IN ('+', '++', '+++', '++++', 'trace') AND locale = 'en')").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                (" + (bgretinopathy.length > 0 ? bgretinopathy : "0") +  ") AND NOT patient_id IN (" +
        (plretinopathy.length > 0 ? plretinopathy : "0") + ")  AND NOT patient_id IN (" +
        (esretinopathy.length > 0 ? esretinopathy : "0") + ") AND NOT patient_id IN (" +
        (cataract.length > 0 ? cataract : "0") + ") AND NOT patient_id IN (" +
        (pvd.length > 0 ? pvd : "0") + ") AND NOT patient_id IN (" +
        (maculopathy.length > 0 ? maculopathy : "0") + ") AND NOT patient_id IN (" +
        (numbness.length > 0 ? numbness : "0") + ") AND NOT patient_id IN (" +
        (amputation.length > 0 ? amputation : "0") + ") AND NOT patient_id IN (" +
        (ulcers.length > 0 ? ulcers : "0") + ") AND NOT patient_id IN (" +
        (creatinine.length > 0 ? creatinine : "0") + ") AND NOT patient_id IN (" +
        (urine.length > 0 ? urine : "0") + ") AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def no_complications
=begin
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                 (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MYOCARDIAL INFARCTION' OR name = 'ANGINA' \
                                      OR name = 'STROKE' OR name = 'PERIPHERAL VASCULAR DISEASE')) AND NOT \
                                    patient_id IN (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CATARACT')) AND NOT patient_id IN \
                                    (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'END STAGE DISEASE')) AND NOT patient_id IN \
                                  (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'PLORIFERATIVE RETINOPATHY')) AND NOT patient_id IN \
                                   (SELECT DISTINCT person_id FROM obs \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'BACKGROUND RETINOPATHY')) AND \
                                      DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                    "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
=end

    bgretinopathy = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'BACKGROUND RETINOPATHY')
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    plretinopathy = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'PLORIFERATIVE RETINOPATHY')
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    esretinopathy = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'END STAGE DISEASE')
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    cataract = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CATARACT')
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    pvd = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MYOCARDIAL INFARCTION' OR name = 'ANGINA' \
                                      OR name = 'STROKE' OR name = 'PERIPHERAL VASCULAR DISEASE')
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    maculopathy = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MACULOPATHY') OR UCASE(value_text) = 'MACULOPATHY'
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    numbness = Order.find_by_sql("SELECT DISTINCT person_id FROM obs
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id WHERE value_coded = \
                                      (SELECT concept_id FROM concept_name where name = 'NUMBNESS SYMPTOMS') \
                                        AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                        ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG'))
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    amputation = Order.find_by_sql("SELECT DISTINCT person_id FROM obs
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name where name = 'AMPUTATION') \
                                      AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                        ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG'))
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    ulcers = Order.find_by_sql("SELECT DISTINCT person_id FROM obs
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name where name = 'CURRENT FOOT ULCERATION') \
                                      AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                      ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG'))
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    creatinine = Order.find_by_sql("SELECT DISTINCT person_id, value_numeric FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                    WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CREATININE') AND COALESCE(value_numeric, 0) >= 1.2
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    urine = Order.find_by_sql("SELECT DISTINCT person_id FROM obs
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id WHERE concept_id = \
                                      (SELECT concept_id FROM concept_name WHERE name = 'URINE PROTEIN') \
                                          AND value_coded IN (SELECT concept_id FROM concept_name
                                          WHERE name IN ('+', '++', '+++', '++++', 'trace') AND locale = 'en')
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                (" + (bgretinopathy.length > 0 ? bgretinopathy : "0") +  ") AND NOT patient_id IN (" +
        (plretinopathy.length > 0 ? plretinopathy : "0") + ")  AND NOT patient_id IN (" +
        (esretinopathy.length > 0 ? esretinopathy : "0") + ") AND NOT patient_id IN (" +
        (cataract.length > 0 ? cataract : "0") + ") AND NOT patient_id IN (" +
        (pvd.length > 0 ? pvd : "0") + ") AND NOT patient_id IN (" +
        (maculopathy.length > 0 ? maculopathy : "0") + ") AND NOT patient_id IN (" +
        (numbness.length > 0 ? numbness : "0") + ") AND NOT patient_id IN (" +
        (amputation.length > 0 ? amputation : "0") + ") AND NOT patient_id IN (" +
        (ulcers.length > 0 ? ulcers : "0") + ") AND NOT patient_id IN (" +
        (creatinine.length > 0 ? creatinine : "0") + ") AND NOT patient_id IN (" +
        (urine.length > 0 ? urine : "0") + ")
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Nephropathy: Urine Protein
  def urine_protein_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE concept_id = \
                                      (SELECT concept_id FROM concept_name WHERE name = 'URINE PROTEIN') \
                                          AND value_coded IN (SELECT concept_id FROM concept_name
                                          WHERE name IN ('+', '++', '+++', '++++', 'trace') AND locale = 'en') AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0
                                        AND patient.patient_id IN (#{ids})").length
  end

  def urine_protein
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                       WHERE concept_id = (SELECT concept_id FROM concept_name WHERE name = 'URINE PROTEIN') \
                                          AND value_coded IN (SELECT concept_id FROM concept_name
                                          WHERE name IN ('+', '++', '+++', '++++', 'trace') AND locale = 'en')\
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Nephropathy: Raised Creatinine >= 1.2mg/dl
  def creatinine_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id, value_numeric FROM obs \
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                    WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CREATININE') AND COALESCE(value_numeric, 0) >= 1.2 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def creatinine
    @orders = Order.find_by_sql("SELECT DISTINCT person_id, value_numeric FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                    WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                      WHERE name = 'CREATININE') AND COALESCE(value_numeric, 0) >= 1.2 \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Neuropathy: Numbness Symptoms
  def numbness_symptoms_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                    WHERE value_coded = \
                                      (SELECT concept_id FROM concept_name where name = 'NUMBNESS SYMPTOMS') \
                                        AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                        ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG')) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def numbness_symptoms
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id WHERE value_coded = \
                                      (SELECT concept_id FROM concept_name where name = 'NUMBNESS SYMPTOMS') \
                                        AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                        ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG')) \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Neuropathy: Amputation
  def amputation_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                    WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name where name = 'AMPUTATION') \
                                      AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                        ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG')) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def amputation
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name where name = 'AMPUTATION') \
                                      AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                        ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG')) \
                                      AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Neuropathy: Current Foot Ulceration
  def current_foot_ulceration_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                    WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name where name = 'CURRENT FOOT ULCERATION') \
                                      AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                      ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG')) AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0 AND patient.patient_id IN (#{ids})").length
  end

  def current_foot_ulceration
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name where name = 'CURRENT FOOT ULCERATION') \
                                      AND concept_id IN (SELECT concept_id FROM concept_name where name IN \
                                      ('LEFT FOOT/LEG', 'RIGHT FOOT/LEG')) \
                                      AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # TB
=begin
  def tb_known_ever

      @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs o WHERE concept_id = \
                                    (SELECT concept_id FROM concept_name where name = 'DIAGNOSIS DATE') \
                                      AND obs_group_id IN (SELECT obs_id FROM obs s WHERE concept_id IN \
                                        (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS')) \
                                        AND DATEDIFF(NOW(), value_datetime)/365 <= 2").length

    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs o
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id WHERE concept_id = \
                                    (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS') \
                                      AND value_coded IN (SELECT DISTINCT concept_id FROM concept_name WHERE name = 'YES') \
                                        AND patient.voided = 0").length


    @orders = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM
                                    (SELECT person_id, value_datetime FROM obs
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id
                                      WHERE concept_id IN (SELECT concept_id FROM concept_name
                                        WHERE name = 'DIABETES DIAGNOSIS DATE') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v1,
                                    (SELECT person_id, value_datetime FROM obs o
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id
                                      WHERE concept_id = (SELECT concept_id FROM concept_name WHERE
                                       name = 'DIAGNOSIS DATE') AND obs_group_id IN (SELECT obs_id FROM obs s WHERE
                                        concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS'))
                                      AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v2
                                      WHERE v1.person_id = v2.person_id").length


  end

  def tb_known

      @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                    LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE concept_id = \
                                    (SELECT concept_id FROM concept_name where name = 'DIAGNOSIS DATE') \
                                      AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id IN \
                                        (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS')) \
                                        AND DATEDIFF(NOW(), value_datetime)/365 <= 2 \
                                      AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                      "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length

    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                    LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE concept_id = \
                                    (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS') \
                                      AND value_coded IN (SELECT DISTINCT concept_id FROM concept_name WHERE name = 'YES') \
                                      AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
   
    tb = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM
                                    (SELECT person_id, value_datetime FROM obs
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id
                                      WHERE concept_id IN (SELECT concept_id FROM concept_name
                                        WHERE name = 'DIABETES DIAGNOSIS DATE') AND patient.voided = 0) AS v1,
                                    (SELECT person_id, value_datetime FROM obs o
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id
                                      WHERE concept_id = (SELECT concept_id FROM concept_name WHERE
                                       name = 'DIAGNOSIS DATE') AND obs_group_id IN (SELECT obs_id FROM obs s WHERE
                                        concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS'))
                                      AND patient.voided = 0) AS v2
                                      WHERE v1.person_id = v2.person_id").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE patient_id IN \
                                (" + (tb.length > 0 ? tb : "0") +  ")
                                AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0").length
  end
                                 AND patient.voided = 0").length
=end



  # TB After Diabetes
  def tb_after_diabetes_ever
    #ids = alive_ever.map{|p| p.patient_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    #ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM \
                                    (SELECT person_id, value_datetime FROM obs \
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                        WHERE name = 'DIABETES DIAGNOSIS DATE') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v1,
                                    (SELECT person_id, value_datetime FROM obs o  \
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id \
                                      WHERE concept_id = (SELECT concept_id FROM concept_name WHERE \
                                       name = 'DIAGNOSIS DATE') AND obs_group_id IN (SELECT obs_id FROM obs s WHERE \
                                        concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS')) \
                                      AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v2
                                      WHERE v1.person_id = v2.person_id AND v1.value_datetime <= v2.value_datetime").length
  end

  def tb_after_diabetes
    @orders = Order.find_by_sql("SELECT v1.person_id FROM \
                                    (SELECT * FROM obs WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                        WHERE name = 'DIABETES DIAGNOSIS DATE')) AS v1, \
                                    (SELECT * FROM obs o WHERE concept_id = (SELECT concept_id FROM concept_name WHERE \
                                       name = 'DIAGNOSIS DATE') AND obs_group_id IN (SELECT obs_id FROM obs s WHERE \
                                        concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS'))) AS v2, \
                                    patient WHERE v1.person_id = v2.person_id AND v1.value_datetime <= v2.value_datetime \
                                      AND patient.patient_id = v1.person_id AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  # TB After Diabetes
  def tb_before_diabetes_ever
    @orders = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM \
                                    (SELECT person_id, value_datetime FROM obs \
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                        WHERE name = 'DIABETES DIAGNOSIS DATE') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v1,
                                    (SELECT person_id, value_datetime FROM obs o  \
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id \
                                      WHERE concept_id = (SELECT concept_id FROM concept_name WHERE \
                                       name = 'DIAGNOSIS DATE') AND obs_group_id IN (SELECT obs_id FROM obs s WHERE \
                                        concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS')) \
                                      AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v2
                                      WHERE v1.person_id = v2.person_id AND v1.value_datetime > v2.value_datetime").length
  end

  def tb_before_diabetes
    @orders = Order.find_by_sql("SELECT v1.person_id FROM \
                                    (SELECT * FROM obs WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                        WHERE name = 'DIABETES DIAGNOSIS DATE')) AS v1, \
                                    (SELECT * FROM obs o WHERE concept_id = (SELECT concept_id FROM concept_name WHERE \
                                       name = 'DIAGNOSIS DATE') AND obs_group_id IN (SELECT obs_id FROM obs s WHERE \
                                        concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS'))) AS v2, \
                                    patient WHERE v1.person_id = v2.person_id AND v1.value_datetime > v2.value_datetime \
                                      AND patient.patient_id = v1.person_id AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  def no_tb_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON \
                              patient.patient_id = obs.person_id WHERE concept_id = (SELECT concept_id \
                              FROM concept_name WHERE name = 'TUBERCULOSIS') AND value_coded IN \
                              (SELECT concept_id FROM concept_name WHERE name = 'NO') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' ").length
  end

  def no_tb
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON \
                              patient.patient_id = obs.person_id WHERE concept_id = (SELECT concept_id \
                              FROM concept_name WHERE name = 'TUBERCULOSIS') AND value_coded IN \
                              (SELECT concept_id FROM concept_name WHERE name = 'NO') AND \
                               DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0").length
  end

  def tb_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON \
                              patient.patient_id = obs.person_id WHERE concept_id = (SELECT concept_id \
                              FROM concept_name WHERE name = 'TUBERCULOSIS') AND value_coded IN \
                              (SELECT concept_id FROM concept_name WHERE name = 'YES') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' ").length
  end

  def tb
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON \
                              patient.patient_id = obs.person_id WHERE concept_id = (SELECT concept_id \
                              FROM concept_name WHERE name = 'TUBERCULOSIS') AND value_coded IN \
                              (SELECT concept_id FROM concept_name WHERE name = 'YES') AND \
                               DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0").length
  end

  def tb_known_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON \
                              patient.patient_id = obs.person_id WHERE concept_id = (SELECT concept_id \
                              FROM concept_name WHERE name = 'TUBERCULOSIS') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' ").length
  end

  def tb_known
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON \
                              patient.patient_id = obs.person_id WHERE concept_id = (SELECT concept_id \
                              FROM concept_name WHERE name = 'TUBERCULOSIS') AND \
                               DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0").length
  end

  def tb_unkown_ever
=begin
    tblasttwoyrs = Order.find_by_sql("SELECT DISTINCT person_id FROM obs o
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id WHERE concept_id = \
                                    (SELECT concept_id FROM concept_name where name = 'DIAGNOSIS DATE') \
                                      AND obs_group_id IN (SELECT obs_id FROM obs s WHERE concept_id IN \
                                        (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS') \
                                        AND patient.voided = 0)").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    tbafter = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM \
                                    (SELECT person_id, value_datetime FROM obs \
                                      LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                        WHERE name = 'DIABETES DIAGNOSIS DATE') AND patient.voided = 0) AS v1,
                                    (SELECT person_id, value_datetime FROM obs o  \
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id \
                                      WHERE concept_id = (SELECT concept_id FROM concept_name WHERE \
                                       name = 'DIAGNOSIS DATE') AND obs_group_id IN (SELECT obs_id FROM obs s WHERE \
                                        concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS')) \
                                      AND patient.voided = 0) AS v2
                                      WHERE v1.person_id = v2.person_id AND v1.value_datetime < v2.value_datetime").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")
    
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                (" + (tblasttwoyrs.length > 0 ? tblasttwoyrs : "0") +  ") AND NOT patient_id IN (" +
                                (tbafter.length > 0 ? tbafter : "0") + ") AND patient.voided = 0").length

    tb = Order.find_by_sql("SELECT DISTINCT person_id FROM obs o
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id WHERE concept_id = \
                                    (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS') \
                                      AND value_coded IN (SELECT DISTINCT concept_id FROM concept_name WHERE name = 'YES') \
                                        AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

=end
    
    tb = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON \
                              patient.patient_id = obs.person_id WHERE concept_id = (SELECT concept_id \
                              FROM concept_name WHERE name = 'TUBERCULOSIS')").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")
    
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                (" + (tb.length > 0 ? tb : "0") +  ") AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  def tb_unkown
=begin
    tblasttwoyrs = Order.find_by_sql("SELECT DISTINCT person_id FROM obs o
                                    LEFT OUTER JOIN patient ON patient.patient_id = o.person_id WHERE concept_id = \
                                    (SELECT concept_id FROM concept_name where name = 'DIAGNOSIS DATE') \
                                      AND obs_group_id IN (SELECT obs_id FROM obs s WHERE concept_id IN \
                                        (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS'))
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                    "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    tbafter = Order.find_by_sql("SELECT v1.person_id FROM \
                                    (SELECT person_id, value_datetime FROM obs
                                    LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id
                                    WHERE concept_id IN (SELECT concept_id FROM concept_name \
                                        WHERE name = 'DIABETES DIAGNOSIS DATE')
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                    "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0) AS v1,
                                    (SELECT person_id, value_datetime FROM obs o
                                    LEFT OUTER JOIN patient ON patient.patient_id = o.person_id
                                    WHERE concept_id = (SELECT concept_id FROM concept_name WHERE \
                                       name = 'DIAGNOSIS DATE') AND obs_group_id IN (SELECT obs_id FROM obs s WHERE \
                                        concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS'))
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                    "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0) AS v2
                                      WHERE v1.person_id = v2.person_id AND v1.value_datetime < v2.value_datetime").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")

    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                (" + (tblasttwoyrs.length > 0 ? tblasttwoyrs : "0") +  ") AND NOT patient_id IN (" +
                                (tbafter.length > 0 ? tbafter : "0") + ")  
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                    "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length

    tb = Order.find_by_sql("SELECT DISTINCT person_id FROM obs o
                                      LEFT OUTER JOIN patient ON patient.patient_id = o.person_id WHERE concept_id = \
                                    (SELECT concept_id FROM concept_name WHERE name = 'TUBERCULOSIS') \
                                      AND value_coded IN (SELECT DISTINCT concept_id FROM concept_name WHERE name = 'YES') \
                                        AND patient.voided = 0").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")
=end

    tb = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON \
                              patient.patient_id = obs.person_id WHERE concept_id = (SELECT concept_id \
                              FROM concept_name WHERE name = 'TUBERCULOSIS')").collect{|o| o.person_id}.compact.delete_if{|x| x == ""}.join(", ")
    
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                (" + (tb.length > 0 ? tb : "0") +  ")
                                AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
                                "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                        AND patient.voided = 0").length
  end

  # HIV Status: Reactive Not on ART
  def reactive_not_on_art_ever
    @orders = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM
                                      (SELECT person_id FROM obs LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE concept_id = (SELECT concept_id FROM concept_name \
                                          WHERE name = 'ON ART') AND value_coded IN (SELECT concept_id FROM concept_name \
                                            WHERE name = 'NO') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v1,
                                      (SELECT person_id FROM obs  LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE value_coded = (SELECT concept_id FROM concept_name \
                                        WHERE name = 'REACTIVE') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v2 WHERE v1.person_id = v2.person_id").length
  end

  def reactive_not_on_art
    @orders = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM
                                      (SELECT * FROM obs WHERE concept_id = (SELECT concept_id FROM concept_name \
                                          WHERE name = 'ON ART') AND value_coded IN (SELECT concept_id FROM concept_name \
                                            WHERE name = 'NO')) AS v1,
                                      (SELECT * FROM obs WHERE value_coded = (SELECT concept_id FROM concept_name \
                                        WHERE name = 'REACTIVE')) AS v2, \
                                    patient WHERE v1.person_id = v2.person_id \
                                      AND patient.patient_id = v1.person_id AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  # HIV Status: Reactive  on ART
  def reactive_on_art_ever
    @orders = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM
                                      (SELECT person_id FROM obs  LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE concept_id = (SELECT concept_id FROM concept_name \
                                          WHERE name = 'ON ART') AND value_coded IN (SELECT concept_id FROM concept_name \
                                            WHERE name = 'YES') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v1,
                                      (SELECT person_id FROM obs  LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE value_coded = (SELECT concept_id FROM concept_name \
                                        WHERE name = 'REACTIVE') AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "') AS v2 WHERE v1.person_id = v2.person_id").length
  end

  def reactive_on_art
    @orders = Order.find_by_sql("SELECT DISTINCT v1.person_id FROM
                                      (SELECT * FROM obs WHERE concept_id = (SELECT concept_id FROM concept_name \
                                          WHERE name = 'ON ART') AND value_coded IN (SELECT concept_id FROM concept_name \
                                            WHERE name = 'YES')) AS v1,
                                      (SELECT * FROM obs WHERE value_coded = (SELECT concept_id FROM concept_name \
                                        WHERE name = 'REACTIVE')) AS v2, \
                                    patient WHERE v1.person_id = v2.person_id \
                                      AND patient.patient_id = v1.person_id AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  # HIV Status: Non Reactive
  def non_reactive_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name WHERE name = 'NON-REACTIVE') and concept_id = \
                                      (SELECT concept_id FROM concept_name WHERE name = 'HIV STATUS') AND \
                                        DATEDIFF(NOW(), obs_datetime)/365 < 1 AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  def non_reactive
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs  \
                                    LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                    WHERE value_coded = (SELECT concept_id FROM concept_name WHERE name = 'NON-REACTIVE') AND \
                                    concept_id = (SELECT concept_id FROM concept_name WHERE name = 'HIV STATUS') AND \
                                        DATEDIFF(NOW(), obs_datetime)/365 < 1 \
                                      AND patient.patient_id = obs.person_id AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # HIV Status: Unknown
  def unknown_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE value_coded = \
                                    (SELECT concept_id FROM concept_name WHERE name = 'NON-REACTIVE') and concept_id = \
                                      (SELECT concept_id FROM concept_name WHERE name = 'HIV STATUS') AND \
                                        DATEDIFF(NOW(), obs_datetime)/365 > 1 AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  def unknown
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs  \
                                    LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                    WHERE value_coded = (SELECT concept_id FROM concept_name WHERE name = 'NON-REACTIVE') AND \
                                    concept_id = (SELECT concept_id FROM concept_name WHERE name = 'HIV STATUS') \
                                      AND patient.patient_id = obs.person_id AND DATEDIFF(NOW(), obs_datetime)/365 > 1 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

  # Outcome
  def dead_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE value_coded IN \
                                    (SELECT concept_id FROM concept_name WHERE name = 'DEAD') AND \
                                      concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'OUTCOME') \
                                      AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'")#.length
  end

  def dead
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs   \
                                    LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE value_coded IN \
                                        (SELECT concept_id FROM concept_name WHERE name = 'DEAD') AND \
                                      concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'OUTCOME') \
                                        AND DATE_FORMAT(obs.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(obs.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0")#.length
  end

  def alive_ever
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                    (SELECT DISTINCT person_id FROM obs WHERE value_coded IN (SELECT concept_id FROM \
                                      concept_name WHERE name = 'DEAD') AND concept_id IN (SELECT concept_id FROM \
                                        concept_name WHERE name = 'OUTCOME')) \
                                    AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'")#.length
  end

  def alive
    @orders = Order.find_by_sql("SELECT DISTINCT patient_id FROM patient WHERE NOT patient_id IN \
                                    (SELECT DISTINCT person_id FROM obs WHERE value_coded IN (SELECT concept_id FROM \
                                      concept_name WHERE name = 'DEAD') AND concept_id IN (SELECT concept_id FROM \
                                        concept_name WHERE name = 'OUTCOME')) \
                                        AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0")#.length
  end

  def transfer_out_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs  LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE value_coded IN \
                                    (SELECT concept_id FROM concept_name WHERE name = 'TRANSFER OUT') AND \
                                      concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'OUTCOME') \
                                    AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'")#.length
  end

  def transfer_out
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs   \
                                    LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE value_coded IN \
                                        (SELECT concept_id FROM concept_name WHERE name = 'TRANSFER OUT') AND \
                                      concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'OUTCOME') \
                                        AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0")#.length
  end

  def stopped_treatment_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs  LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                        WHERE value_coded IN \
                                    (SELECT concept_id FROM concept_name WHERE name = 'TREATMENT STOPPED') AND \
                                      concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'OUTCOME') \
                                    AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'")#.length
  end

  def stopped_treatment
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs   \
                                    LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                      WHERE value_coded IN \
                                        (SELECT concept_id FROM concept_name WHERE name = 'TREATMENT STOPPED') AND \
                                      concept_id IN (SELECT concept_id FROM concept_name WHERE name = 'OUTCOME') \
                                        AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0")#.length
  end

  # Treatment (Alive and Even Defaulters)
  def on_diet_ever
    ids = alive_ever.map{|p| p.patient_id} - dead_ever.map{|p| p.person_id} - defaulters_ever.map{|p| p.patient_id} - transfer_out_ever.map{|p| p.person_id} - stopped_treatment_ever.map {|p| p.person_id}
    ids = ids.join(',') rescue ""
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders \
                                  LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                  WHERE NOT order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE (name LIKE '%lente%' AND name LIKE '%insulin%') OR \
                                        (name LIKE '%soluble%' AND name LIKE '%insulin%') OR (name LIKE '%glibenclamide%') OR \
                                        (name LIKE '%metformin%'))) \
                                    AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'
                                        AND patient.patient_id IN (#{ids})")#.length
  end

  def on_diet
    @orders = Order.find_by_sql("SELECT DISTINCT orders.patient_id FROM orders LEFT OUTER JOIN patient ON \
                                        patient.patient_id = orders.patient_id WHERE NOT order_id IN \
                                    (SELECT order_id FROM drug_order \
                                      WHERE drug_inventory_id IN \
                                        (SELECT drug_id FROM drug d WHERE (name LIKE '%lente%' AND name LIKE '%insulin%') OR \
                                        (name LIKE '%soluble%' AND name LIKE '%insulin%') OR (name LIKE '%glibenclamide%') OR \
                                        (name LIKE '%metformin%'))) AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + 
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'")#.length
  end

  # Outcome: Defaulters
  def defaulters_ever
    @orders = Order.find_by_sql("SELECT orders.patient_id FROM orders \
                                  LEFT OUTER JOIN patient ON patient.patient_id = orders.patient_id \
                                  WHERE DATEDIFF('#{@end_date}', auto_expire_date)/30 > 6 \
                                    AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'  \
                                    GROUP BY patient_id")#.length
  end

  def defaulters
    @orders = Order.find_by_sql("SELECT orders.patient_id FROM orders LEFT OUTER JOIN patient ON \
                                        patient.patient_id = orders.patient_id WHERE DATEDIFF('#{@end_date}', auto_expire_date)/30 > 6 \
                                        AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" +
        @start_date + "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0 \
                                          GROUP BY patient_id")#.length
  end

  # Maculopathy
  def maculopathy_ever
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                  LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                  WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MACULOPATHY') OR UCASE(value_text) = 'MACULOPATHY' \
                                    AND patient.voided = 0 AND \
                                        DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "'").length
  end

  def maculopathy
    @orders = Order.find_by_sql("SELECT DISTINCT person_id FROM obs \
                                   LEFT OUTER JOIN patient ON patient.patient_id = obs.person_id \
                                   WHERE value_coded = (SELECT concept_id FROM concept_name \
                                      WHERE name = 'MACULOPATHY') OR UCASE(value_text) = 'MACULOPATHY' \
                                    AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') >= '" + @start_date +
        "' AND DATE_FORMAT(patient.date_created, '%Y-%m-%d') <= '" + @end_date + "' \
                                    AND patient.voided = 0").length
  end

end

/* ///////////////////////////////////////////// PAG 1 ///////////////////////////////////////////// */

/*1 Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia*/

SELECT `degrees`.`name`, `students`.`name`,`students`.`surname`, `students`.`registration_number`, `degrees`.`name`,`degrees`.`id`  
FROM `degrees`
JOIN `students`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name`= "corso di laurea in economia";

/*2 Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze*/

SELECT * 
FROM `departments`
JOIN `degrees`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name`LIKE'%neuroscienze%'AND `degrees`.`level`="magistrale";

/*3 Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)*/

SELECT * 
FROM `courses`
JOIN `course_teacher`
JOIN`teachers`
WHERE `teachers`.`name`="Fulvio" 
AND `teachers`.`surname`="Amato" 
AND `course_teacher`.`teacher_id`=`teachers`.`id`
AND `course_teacher`.`course_id`=`courses`.`id`;

/*4 Selezionare tutti gli studenti con i dati relativi al corso di laurea
    a cui sono iscritti e il relativo dipartimento, 
    in ordine alfabetico per cognome e nome*/

SELECT `students`.`surname`, `students`.`name`, `students`.`degree_id`, `degrees`.`name`, `departments`.`name`
FROM `students`
JOIN `degrees`
JOIN `departments`

ON `degrees`.`id`=`students`.`degree_id` 
AND `departments`.`id`=`degrees`.`department_id`

ORDER BY `students`.`surname` ,
			`students`.`name`;    


/*5 Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti*/

SELECT `degrees`.`name`, `courses`.`degree_id`,`courses`.`name` , `teachers`.`name`, `teachers`.`surname`
FROM `degrees`
JOIN `teachers`
JOIN `courses`
JOIN `course_teacher`
ON `degrees`.`id`=`courses`.`degree_id` AND `courses`.`id`=`course_teacher`.`course_id` AND `course_teacher`.`teacher_id`=`teachers`.`id`

ORDER BY `degrees`.`name`;

/*6 Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)*/

SELECT `departments`.`name`, `degrees`.`name`, `courses`.`degree_id`,`courses`.`name` , `teachers`.`name`, `teachers`.`surname`
FROM `degrees`
JOIN `teachers`
JOIN `courses`
JOIN `course_teacher`
JOIN `departments`
ON `degrees`.`id`=`courses`.`degree_id` 
	AND `courses`.`id`=`course_teacher`.`course_id` 
    AND `course_teacher`.`teacher_id`=`teachers`.`id` 
    AND `departments`.`name`LIKE'%matematica%' 
    AND `departments`.`id`=`degrees`.`department_id`

ORDER BY `degrees`.`name`;

/*7 BONUS: Selezionare per ogni studente il numero di tentativi sostenuti
    per ogni esame, stampando anche il voto massimo. Successivamente,
    filtrare i tentativi con voto minimo 18*/

SELECT COUNT(*) AS `numero_esami`, `students`.`id` 
FROM `exams`
JOIN `students`
ON `students`.`id`=`exam_student`.`student_id`
GROUP BY `student_id`


ORDER BY `students`.`surname`,
			`students`.`name`,
				`exam_student`.`exam_id`;

                /*al momento non pare funzionare*/





/* ////////////////////////////////////// PAG 2 ////////////////////////////////////// */


/* 1. Contare quanti iscritti ci sono stati ogni anno*/

SELECT COUNT(`id`), YEAR(`enrolment_date`)
FROM `students`
GROUP BY YEAR(`enrolment_date`);


/* 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio*/

SELECT `office_address` AS "indirizzo_edificio", COUNT(`id`) AS "num_insegnanti"
FROM `teachers`
GROUP BY `office_address`;


/* 3. Calcolare la media dei voti di ogni appello d'esame*/

SELECT `exam_id` AS "appello_esame" , AVG(`vote`) AS "media_voti"
FROM `exam_student`
GROUP BY `exam_id`;


/* 4. Contare quanti corsi di laurea ci sono per ogni dipartimento*/

SELECT `department_id` AS "dipartimento", COUNT(`id`) AS "num_corsi_laurea"
FROM `degrees`
GROUP BY `department_id`;

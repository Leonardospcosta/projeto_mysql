/*
Esta consulta SQL utiliza uma expressão de tabela comum (CTE) para calcular o status de "salto de fila" com base nas interações de chat em uma tabela de suporte técnico. Ela identifica se houve um atraso na fila entre interações consecutivas e atribui o status "Delayed" quando aplicável.
A CTE organiza as informações dos chats em ordem de início e calcula a próxima primeira interação. A consulta principal, então, compara as datas das primeiras interações para determinar o status de salto de fila.
*/


WITH cte AS ( SELECT CHAT_ID, USER_NAME, EMPLOYEE_ID, CHAT_START, CHAT_END, FIRST_INTERACTION, LAST_INTERACTION, LEAD(FIRST_INTERACTION) OVER (ORDER BY CHAT_START) AS NEXT_FIRST_INTERACTION FROM TB_TECH_SUPPORT_CHAT_CONSULT ORDER BY CHAT_START ) 
SELECT CHAT_ID, USER_NAME, EMPLOYEE_ID, CHAT_START, CHAT_END, FIRST_INTERACTION, LAST_INTERACTION, CASE WHEN NEXT_FIRST_INTERACTION IS NOT NULL AND FIRST_INTERACTION > NEXT_FIRST_INTERACTION THEN 'Delayed' ELSE NULL END AS QUEUE_JUMP_STATUS FROM cte;

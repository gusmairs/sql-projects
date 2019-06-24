SELECT
        logins.userid,
        registrations.tmstmp as regdate,
        MAX(logins.tmstmp) as lastlogin
FROM registrations
JOIN logins ON registrations.userid = logins.userid
GROUP BY logins.userid, registrations.tmstmp;

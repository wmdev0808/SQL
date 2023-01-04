<!-- main html file for SID (php version) -->
<?php echo $SID["MESSAGES"] ?><?php echo $SID["ERRORS"] ?>
<div class="form">
<form action="<?php echo $SID["SELF"] ?>" method="post" target="_self">
<table class="title_area"><tr>
<td><p class="prompt">SQL:</p></td>
<td align="right">
<p class="prompt">Database: <select size="1" name="select_database">
<?php echo $SID["DATABASE_SELECT_LIST"] ?>
</select></p>
</td>
</tr></table>
    <p class="SQLfield"><textarea class="SQLfield" name="SQLfield"><?php echo $SID["SQLfield"] ?></textarea></p>
    <p class="go_button"><input class="go_button" type="submit" value=" Go "></p>
    <input type="hidden" name="a" value="go">
</form>
</div>
<?php echo $SID["CONTENT"] ?>

<?php

function smarty_modifier_header()
{
	return JWUtility::GetHeaderNameByUrl();
}

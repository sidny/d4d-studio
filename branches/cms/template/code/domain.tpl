package com.i139.observer.daemon.domain;

public class <{$table|javaClassName}> extends BaseDto {
<{foreach item=item from=$column}>
	private <{$item.type|javaType}> <{$item.field|javaClassName:1}>;

	public <{$item.type|javaType}> get<{$item.field|javaClassName}>() {
		return <{$item.field|javaClassName:1}>;
	}
	public void set<{$item.field|javaClassName}>(<{$item.type|javaType}> <{$item.field|javaClassName:1}>) {
		this.<{$item.field|javaClassName:1}> = <{$item.field|javaClassName:1}>;
	}
<{/foreach}>
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append(this.getClass().getSimpleName());
		builder.append(" [");
<{foreach item=item from=$column name="javaCol"}>
		builder.append("<{$item.field|javaClassName:1}>=");
		builder.append(<{$item.field|javaClassName:1}>);
<{if !$smarty.foreach.javaCol.last}>
		builder.append(",");<{/if}>	
<{/foreach}>
		builder.append("]");
		return builder.toString();
	}
}

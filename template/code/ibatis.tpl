<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd" >

<sqlMap namespace="<{$table}>">
	<typeAlias alias="<{$table|javaClassName}>" type="com.i139.observer.daemon.domain.<{$table|javaClassName}>"></typeAlias>
	<resultMap id="<{$table|javaClassName}>Result" class="<{$table|javaClassName}>">
<{foreach from=$column item=item}>
		<result column="<{$item.field}>" property="<{$item.field|javaClassName:1}>" jdbcType="<{$item.type|jdbcType}>" />
<{/foreach}>
	</resultMap>
	<sql id="<{$table|javaClassName}>.whereClause">
		<dynamic prepend="where">
		<{foreach item=item from=$column}>
			<isNotNull prepend="and" property="<{$item.field|javaClassName:1}>">
				<{$item.field}> = #<{$item.field|javaClassName:1}>:<{$item.type|jdbcType}>#
			</isNotNull>
		<{/foreach}>
		</dynamic>
	</sql>

	<delete id="<{$table|javaClassName}>.delete" parameterClass="<{$table|javaClassName}>">
		delete from <{$table}> where id = #id:INTEGER# </delete>
	<insert id="<{$table|javaClassName}>.insert" parameterClass="<{$table|javaClassName}>">
		insert into <{$table}> (
		<{foreach item=item from=$column name=insertCol}><{if $item.field !='id'}>
		<{$item.field}><{if !$smarty.foreach.insertCol.last}>,<{/if}>

		<{/if}><{/foreach}>
		)
		values (
		<{foreach item=item from=$column name="insertVal"}><{if $item.field !='id'}>
		#<{$item.field|javaClassName:1}>:<{$item.type|jdbcType}>#<{if !$smarty.foreach.insertVal.last}>,<{/if}>

		<{/if}><{/foreach}>
		)
		<selectKey resultClass="int" type="post" keyProperty="id"> select
			LAST_INSERT_ID() as value </selectKey>
	</insert>
	<update id="<{$table|javaClassName}>.update"  parameterClass="<{$table|javaClassName}>">
		update <{$table}> set
		<{foreach item=item from=$column name="updateCol"}><{if $item.field !='id'}>
		<{$item.field}> = #<{$item.field|javaClassName:1}>:<{$item.type|jdbcType}>#<{if !$smarty.foreach.updateCol.last}>,
		<{/if}><{/if}><{/foreach}>
		
		where id = #id:INTEGER#
    </update>
	<update id="<{$table|javaClassName}>.updateBySelective" parameterClass="<{$table|javaClassName}>">
		update <{$table}>
		<dynamic prepend="set">
<{foreach item=item from=$column}>
<{if $item.field !='id'}>
		<isNotNull prepend="," property="<{$item.field|javaClassName:1}>">
				<{$item.field}> = #<{$item.field|javaClassName:1}>:<{$item.type|jdbcType}>#
			</isNotNull>
		<{/if}><{/foreach}>
		</dynamic>
		where id = #id:INTEGER#
	</update>
	<select id="<{$table|javaClassName}>.select" resultMap="<{$table|javaClassName}>Result"
		parameterClass="<{$table|javaClassName}>">
		select
<{foreach item=item from=$column name=selectCol}>
		<{$item.field}><{if !$smarty.foreach.selectCol.last}>,
<{/if}><{/foreach}>
		
		from <{$table}>
		<isParameterPresent>
			<include refid="<{$table|javaClassName}>.whereClause"></include>
		</isParameterPresent>
	</select>
	<select id="<{$table|javaClassName}>.count" resultClass="java.lang.Integer">
		select count(*) from <{$table}>
		<isParameterPresent>
			<include refid="<{$table|javaClassName}>.whereClause"></include>
		</isParameterPresent>
	</select>
</sqlMap>

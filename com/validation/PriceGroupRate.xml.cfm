<?xml version="1.0" encoding="UTF-8"?>
<validateThis xsi:noNamespaceSchemaLocation="validateThis.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<conditions>
		<condition name="isNotGlobal" serverTest="getGlobalFlag() EQ 0" />
	</conditions>
	<contexts>
		<context name="save" />
		<context name="delete" />
		<context name="edit" />
	</contexts>
	<objectProperties>
		<property name="priceGroup">
			<rule type="required" contexts="save" />
		</property>
		<property name="amountType">
			<rule type="required" contexts="save" />
		</property>
		<property name="amount">
			<rule type="required" contexts="save" />
			<rule type="numeric" contexts="save" />
		</property>
	</objectProperties>
</validateThis>
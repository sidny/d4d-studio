using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.Serialization;
using System.Security.Permissions;

namespace Core.Data.Exceptions
{
	/// <summary>
	/// Thrown by Entity Procedure class
	/// </summary>
	[Serializable]
	public class EntityProcedureException : DatabaseExecutionException
	{
		#region Instance Type
		private Type instanceType;

		/// <summary>
		/// Type of generic instance used in EntityProcedure call
		/// </summary>
		public Type InstanceType
		{
			get { return instanceType; }
			set { instanceType = value; }
		}
		#endregion

		/// <summary>
		/// Creates instance of <see cref="EntityProcedureException"/>
		/// </summary>
		/// <param name="database"></param>
		/// <param name="procedureName"></param>
		/// <param name="innerException"></param>
		public EntityProcedureException(Database database, string procedureName, Exception innerException)
			: base(database, procedureName, innerException)
		{
		}

		/// <summary>
		/// Creates instance of <see cref="EntityProcedureException"/>
		/// </summary>
		/// <param name="database"></param>
		/// <param name="procedureName"></param>
		/// <param name="instanceType"></param>
		/// <param name="innerException"></param>
		public EntityProcedureException(Database database, string procedureName, Type instanceType, Exception innerException)
			: base(database, procedureName, "Instance type: " + instanceType.ToString(), innerException)
		{
			this.instanceType = instanceType;
		}

		#region Exception serialization support
		/// <summary>
		/// Deserializes exception
		/// </summary>
		/// <param name="info"></param>
		/// <param name="context"></param>
		protected EntityProcedureException(SerializationInfo info, StreamingContext context)
			: base(info, context)
		{
			// get the custom property out of the serialization stream and set the object's properties
			this.instanceType = (Type)info.GetValue("InstanceType", typeof(Type));
		}

		/// <summary>
		/// Serializes exception
		/// </summary>
		/// <param name="info"></param>
		/// <param name="context"></param>
		[SecurityPermissionAttribute(SecurityAction.Demand, SerializationFormatter = true)]
		public override void GetObjectData(SerializationInfo info, StreamingContext context)
		{
			// add the custom property into the serialization stream
			info.AddValue("InstanceType", this.instanceType);

			// call the base exception class to ensure proper serialization
			base.GetObjectData(info, context);
		}
		#endregion
	}
}

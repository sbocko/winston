package sk.upjs.winston

class Role {
	public static final String ROLE_USER = 'ROLE_USER'

	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}

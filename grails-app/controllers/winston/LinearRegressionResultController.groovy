package winston

import grails.plugin.springsecurity.annotation.Secured
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured([Role.ROLE_USER])
class LinearRegressionResultController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond LinearRegressionResult.list(params), model:[linearRegressionResultInstanceCount: LinearRegressionResult.count()]
    }

    def show(LinearRegressionResult linearRegressionResultInstance) {
        respond linearRegressionResultInstance
    }

    def create() {
        respond new LinearRegressionResult(params)
    }

    @Transactional
    def save(LinearRegressionResult linearRegressionResultInstance) {
        if (linearRegressionResultInstance == null) {
            notFound()
            return
        }

        if (linearRegressionResultInstance.hasErrors()) {
            respond linearRegressionResultInstance.errors, view:'create'
            return
        }

        linearRegressionResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'linearRegressionResult.label', default: 'LinearRegressionResult'), linearRegressionResultInstance.id])
                redirect linearRegressionResultInstance
            }
            '*' { respond linearRegressionResultInstance, [status: CREATED] }
        }
    }

    def edit(LinearRegressionResult linearRegressionResultInstance) {
        respond linearRegressionResultInstance
    }

    @Transactional
    def update(LinearRegressionResult linearRegressionResultInstance) {
        if (linearRegressionResultInstance == null) {
            notFound()
            return
        }

        if (linearRegressionResultInstance.hasErrors()) {
            respond linearRegressionResultInstance.errors, view:'edit'
            return
        }

        linearRegressionResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'LinearRegressionResult.label', default: 'LinearRegressionResult'), linearRegressionResultInstance.id])
                redirect linearRegressionResultInstance
            }
            '*'{ respond linearRegressionResultInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(LinearRegressionResult linearRegressionResultInstance) {

        if (linearRegressionResultInstance == null) {
            notFound()
            return
        }

        linearRegressionResultInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'LinearRegressionResult.label', default: 'LinearRegressionResult'), linearRegressionResultInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'linearRegressionResult.label', default: 'LinearRegressionResult'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
